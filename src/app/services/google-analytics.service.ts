import { Injectable } from '@angular/core';
import { Router, NavigationEnd } from '@angular/router';
import { filter } from 'rxjs/operators';

declare let gtag: Function;

@Injectable({
  providedIn: 'root'
})
export class GoogleAnalyticsService {
  private readonly GA_TRACKING_ID = 'G-XXXXXXXXXX'; // Replace with your actual GA4 tracking ID

  constructor(private router: Router) {}

  initializeGoogleAnalytics(): void {
    // Add Google Analytics script
    const script = document.createElement('script');
    script.async = true;
    script.src = `https://www.googletagmanager.com/gtag/js?id=${this.GA_TRACKING_ID}`;
    document.head.appendChild(script);

    // Initialize gtag
    const gtagScript = document.createElement('script');
    gtagScript.innerHTML = `
      window.dataLayer = window.dataLayer || [];
      function gtag(){dataLayer.push(arguments);}
      gtag('js', new Date());
      gtag('config', '${this.GA_TRACKING_ID}', {
        page_title: document.title,
        page_location: window.location.href
      });
    `;
    document.head.appendChild(gtagScript);

    // Track route changes
    this.router.events.pipe(
      filter(event => event instanceof NavigationEnd)
    ).subscribe((event: NavigationEnd) => {
      this.trackPageView(event.urlAfterRedirects);
    });
  }

  trackPageView(url: string): void {
    if (typeof gtag !== 'undefined') {
      gtag('config', this.GA_TRACKING_ID, {
        page_path: url,
        page_title: document.title,
        page_location: window.location.href
      });
    }
  }

  trackEvent(eventAction: string, eventCategory: string, eventLabel?: string, value?: number): void {
    if (typeof gtag !== 'undefined') {
      gtag('event', eventAction, {
        event_category: eventCategory,
        event_label: eventLabel,
        value: value
      });
    }
  }

  // Track business-specific events
  trackServiceInquiry(service: string): void {
    this.trackEvent('service_inquiry', 'engagement', service);
  }

  trackContactForm(formType: string): void {
    this.trackEvent('contact_form_submit', 'engagement', formType);
  }

  trackQuoteRequest(service: string): void {
    this.trackEvent('quote_request', 'conversion', service);
  }

  trackPhoneCall(): void {
    this.trackEvent('phone_call', 'engagement', 'header_phone');
  }

  trackEmailClick(): void {
    this.trackEvent('email_click', 'engagement', 'contact_email');
  }

  trackSocialMediaClick(platform: string): void {
    this.trackEvent('social_media_click', 'engagement', platform);
  }

  trackDownload(fileName: string): void {
    this.trackEvent('download', 'engagement', fileName);
  }

  trackOutboundLink(url: string): void {
    this.trackEvent('outbound_link', 'engagement', url);
  }
}
