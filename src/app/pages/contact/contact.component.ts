import { Component } from '@angular/core';
import { FormBuilder, FormGroup, Validators, ReactiveFormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { EmailService } from '../../services/email.service';

@Component({
  selector: 'app-contact',
  imports: [ReactiveFormsModule, CommonModule],
  templateUrl: './contact.component.html',
  styleUrl: './contact.component.css'
})
export class ContactComponent {
  contactForm: FormGroup;
  isSubmitting = false;
  submitMessage = '';
  submitSuccess = false;

  constructor(
    private fb: FormBuilder, 
    private emailService: EmailService
  ) {
    this.contactForm = this.fb.group({
      name: ['', [Validators.required, Validators.minLength(2)]],
      email: ['', [Validators.required, Validators.email]],
      phone: [''],
      company: [''],
      service: [''],
      budget: [''],
      timeline: [''],
      message: ['', [Validators.required, Validators.minLength(10)]]
    });
  }

  onSubmit() {
    if (this.contactForm.valid) {
      this.isSubmitting = true;
      this.submitMessage = '';
      
      const formData = this.contactForm.value;
      
      // Create email data
      const emailData = {
        to: 'arvind.verma@avtechcompany.in',
        subject: `New Contact Form Submission from ${formData.name}`,
        html: this.emailService.formatContactFormEmail(formData),
        from_name: formData.name,
        from_email: formData.email
      };

      // Send email
      this.sendEmail(emailData);
      
    } else {
      this.markFormGroupTouched();
    }
  }

  private sendEmail(emailData: any) {
    // For production, you would use EmailJS or a backend service
    // For now, we'll simulate the email sending and show the email content
    
    console.log('Email would be sent with the following data:', emailData);
    
    // Simulate email sending
    setTimeout(() => {
      this.isSubmitting = false;
      this.submitSuccess = true;
      this.submitMessage = 'Thank you for your message! We have received your inquiry and will get back to you within 24 hours.';
      
      // Also show the email content in console for testing
      console.log('Email HTML content:', emailData.html);
      
      this.contactForm.reset();
      
      // Reset success message after 7 seconds
      setTimeout(() => {
        this.submitMessage = '';
        this.submitSuccess = false;
      }, 7000);
    }, 2000);
  }

  private markFormGroupTouched() {
    Object.keys(this.contactForm.controls).forEach(key => {
      this.contactForm.get(key)?.markAsTouched();
    });
  }

  // Helper methods for template
  isFieldInvalid(fieldName: string): boolean {
    const field = this.contactForm.get(fieldName);
    return field ? field.invalid && field.touched : false;
  }

  getFieldError(fieldName: string): string {
    const field = this.contactForm.get(fieldName);
    if (field && field.errors && field.touched) {
      if (field.errors['required']) return `${this.getFieldDisplayName(fieldName)} is required`;
      if (field.errors['email']) return 'Please enter a valid email address';
      if (field.errors['minlength']) {
        const minLength = field.errors['minlength'].requiredLength;
        return `${this.getFieldDisplayName(fieldName)} must be at least ${minLength} characters`;
      }
    }
    return '';
  }

  private getFieldDisplayName(fieldName: string): string {
    const displayNames: { [key: string]: string } = {
      'name': 'Full Name',
      'email': 'Email Address',
      'message': 'Project Description'
    };
    return displayNames[fieldName] || fieldName;
  }
}
