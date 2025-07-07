# Email Service Setup Guide

This guide explains how to set up email functionality for the AVtech contact form.

## Current Status

The contact form is now fully functional with:
- Form validation
- Loading states
- Success/error messages
- Email formatting
- All form data will be sent to: `arvind.verma@avtechcompany.in`

## Setup Options

### Option 1: EmailJS (Recommended - Free)

EmailJS allows you to send emails directly from the frontend without a backend server.

1. **Sign up at https://www.emailjs.com/**
2. **Create a service:**
   - Go to Email Services
   - Add a new service (Gmail, Outlook, etc.)
   - Connect your email account
   - Note down the Service ID

3. **Create an email template:**
   - Go to Email Templates
   - Create a new template with these variables:
     ```
     Subject: {{subject}}
     From: {{from_name}} <{{from_email}}>
     To: arvind.verma@avtechcompany.in
     
     Content:
     {{{message_html}}}
     ```
   - Note down the Template ID

4. **Get your User ID:**
   - Go to Account settings
   - Copy your User ID

5. **Update the service:**
   - Open `src/app/services/email.service.ts`
   - Replace the following values:
     ```typescript
     const serviceID = 'your_service_id';      // Replace with your Service ID
     const templateID = 'your_template_id';    // Replace with your Template ID
     const userID = 'your_user_id';            // Replace with your User ID
     ```

6. **Enable the service:**
   - In `src/app/pages/contact/contact.component.ts`
   - Replace the `sendEmail` method with:
     ```typescript
     private sendEmail(emailData: any) {
       this.emailService.sendEmailWithEmailJS(emailData).subscribe({
         next: (response) => {
           this.isSubmitting = false;
           this.submitSuccess = true;
           this.submitMessage = 'Thank you for your message! We have received your inquiry and will get back to you within 24 hours.';
           this.contactForm.reset();
           
           setTimeout(() => {
             this.submitMessage = '';
             this.submitSuccess = false;
           }, 7000);
         },
         error: (error) => {
           this.isSubmitting = false;
           this.submitSuccess = false;
           this.submitMessage = 'Sorry, there was an error sending your message. Please try again or contact us directly.';
           console.error('Email sending failed:', error);
         }
       });
     }
     ```

### Option 2: Backend API

If you prefer to use a backend service:

1. **Create a backend API endpoint** (Node.js, PHP, Python, etc.)
2. **Update the service:**
   - In `src/app/services/email.service.ts`
   - Update the `sendEmailViaBackend` method with your API endpoint
3. **Use the backend method:**
   - In the contact component, call `this.emailService.sendEmailViaBackend(emailData)`

### Option 3: Direct SMTP (Advanced)

For production applications, consider using a dedicated email service like:
- SendGrid
- Mailgun
- Amazon SES
- Twilio SendGrid

## Testing

Currently, the form is set to simulation mode. When you submit the form:
1. It will show a success message
2. The email data will be logged to the browser console
3. You can check the console to see the formatted email content

## Email Template

The email sent will include:
- Contact Information (Name, Email, Phone, Company)
- Project Details (Service, Budget, Timeline)
- Project Description
- Submission timestamp

## Form Features

- **Validation:** Required fields and email format validation
- **Loading States:** Shows "Sending..." while processing
- **Success/Error Messages:** Clear feedback to users
- **Responsive Design:** Works on all devices
- **Accessibility:** Proper labels and error messages

## Security Notes

- Never expose sensitive API keys in frontend code
- Use environment variables for production
- Consider rate limiting for contact form submissions
- Implement CAPTCHA for spam protection if needed

## Troubleshooting

1. **Form not submitting:** Check browser console for errors
2. **Validation errors:** Ensure all required fields are filled
3. **Email not sending:** Verify EmailJS configuration
4. **Styling issues:** Check CSS imports and responsive design

## Next Steps

1. Set up EmailJS account and configure the service
2. Test the email functionality
3. Optionally add CAPTCHA for spam protection
4. Monitor email delivery and form submissions
