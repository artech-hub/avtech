import { Injectable, Optional } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, of } from 'rxjs';

export interface EmailData {
  to: string;
  subject: string;
  html: string;
  from_name?: string;
  from_email?: string;
}

@Injectable({
  providedIn: 'root'
})
export class EmailService {
  
  constructor(@Optional() private http: HttpClient) {}

  /**
   * Send email using EmailJS service
   * You need to:
   * 1. Sign up at https://www.emailjs.com/
   * 2. Create a service (Gmail, Outlook, etc.)
   * 3. Create an email template
   * 4. Replace the IDs below with your actual EmailJS credentials
   */
  sendEmailWithEmailJS(emailData: EmailData): Observable<any> {
    if (!this.http) {
      console.warn('HttpClient not available. Email sending is simulated.');
      return of({ success: true, message: 'Email simulated successfully' });
    }

    const serviceID = 'service_your_id';  // Replace with your EmailJS service ID
    const templateID = 'template_your_id'; // Replace with your EmailJS template ID
    const userID = 'your_user_id';        // Replace with your EmailJS user ID

    const templateParams = {
      to_email: emailData.to,
      from_name: emailData.from_name || 'Website Contact Form',
      from_email: emailData.from_email || 'noreply@avtech.com',
      subject: emailData.subject,
      message_html: emailData.html
    };

    // EmailJS API endpoint
    const emailJSUrl = `https://api.emailjs.com/api/v1.0/email/send`;
    
    const payload = {
      service_id: serviceID,
      template_id: templateID,
      user_id: userID,
      template_params: templateParams
    };

    return this.http.post(emailJSUrl, payload);
  }

  /**
   * Alternative: Send email using a backend service
   * You would need to create a backend API endpoint for this
   */
  sendEmailViaBackend(emailData: EmailData): Observable<any> {
    if (!this.http) {
      console.warn('HttpClient not available. Email sending is simulated.');
      return of({ success: true, message: 'Email simulated successfully' });
    }

    // Replace with your backend API endpoint
    const backendUrl = 'https://your-backend-api.com/send-email';
    
    return this.http.post(backendUrl, emailData);
  }

  /**
   * Format contact form data into email HTML
   */
  formatContactFormEmail(formData: any): string {
    return `
      <div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto;">
        <h2 style="color: #3498DB; border-bottom: 2px solid #3498DB; padding-bottom: 10px;">
          New Contact Form Submission
        </h2>
        
        <div style="background-color: #f8f9fa; padding: 20px; border-radius: 8px; margin: 20px 0;">
          <h3 style="color: #2c3e50; margin-top: 0;">Contact Information</h3>
          <p><strong>Name:</strong> ${formData.name}</p>
          <p><strong>Email:</strong> <a href="mailto:${formData.email}">${formData.email}</a></p>
          <p><strong>Phone:</strong> ${formData.phone || 'Not provided'}</p>
          <p><strong>Company:</strong> ${formData.company || 'Not provided'}</p>
        </div>
        
        <div style="background-color: #e8f4fd; padding: 20px; border-radius: 8px; margin: 20px 0;">
          <h3 style="color: #2c3e50; margin-top: 0;">Project Details</h3>
          <p><strong>Service Interested In:</strong> ${this.formatServiceName(formData.service)}</p>
          <p><strong>Budget:</strong> ${this.formatBudget(formData.budget)}</p>
          <p><strong>Timeline:</strong> ${formData.timeline || 'Not specified'}</p>
        </div>
        
        <div style="background-color: #fff; padding: 20px; border: 1px solid #ddd; border-radius: 8px; margin: 20px 0;">
          <h3 style="color: #2c3e50; margin-top: 0;">Project Description</h3>
          <p style="line-height: 1.6;">${formData.message.replace(/\n/g, '<br>')}</p>
        </div>
        
        <div style="border-top: 1px solid #ddd; padding-top: 20px; margin-top: 30px; color: #666; font-size: 0.9em;">
          <p>This message was sent from the AVtech website contact form.</p>
          <p>Submitted on: ${new Date().toLocaleString()}</p>
        </div>
      </div>
    `;
  }

  private formatServiceName(service: string): string {
    if (!service) return 'Not specified';
    
    const serviceMap: { [key: string]: string } = {
      'web-development': 'Web Development',
      'mobile-development': 'Mobile App Development',
      'cloud-solutions': 'Cloud Solutions',
      'digital-marketing': 'Digital Marketing',
      'ui-ux-design': 'UI/UX Design',
      'consulting': 'Consulting Services',
      'other': 'Other'
    };
    
    return serviceMap[service] || service;
  }

  private formatBudget(budget: string): string {
    if (!budget) return 'Not specified';
    
    const budgetMap: { [key: string]: string } = {
      'under-5k': 'Under ₹5,00,000',
      '5k-10k': '₹5,00,000 - ₹10,00,000',
      '10k-25k': '₹10,00,000 - ₹25,00,000',
      '25k-50k': '₹25,00,000 - ₹50,00,000',
      '50k-plus': '₹50,00,000+'
    };
    
    return budgetMap[budget] || budget;
  }
}
