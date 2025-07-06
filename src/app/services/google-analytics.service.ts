import { Injectable } from '@angular/core';

declare let gtag: Function;

@Injectable({
  providedIn: 'root'
})
export class GoogleAnalyticsService {

  constructor() { }

  public trackEvent(action: string, category: string, label?: string, value?: number) {
    gtag('event', action, {
      event_category: category,
      event_label: label,
      value: value
    });
  }

  public trackPageView(url: string) {
    gtag('config', 'GA_MEASUREMENT_ID', {
      page_path: url
    });
  }

  public trackCustomEvent(eventName: string, parameters: any) {
    gtag('event', eventName, parameters);
  }

  // Track form submissions
  public trackFormSubmission(formName: string) {
    this.trackEvent('form_submit', 'engagement', formName);
  }

  // Track button clicks
  public trackButtonClick(buttonName: string) {
    this.trackEvent('click', 'engagement', buttonName);
  }

  // Track service page views
  public trackServiceView(serviceName: string) {
    this.trackEvent('service_view', 'services', serviceName);
  }

  // Track contact form submissions
  public trackContactSubmission(service: string) {
    this.trackEvent('contact_form', 'lead_generation', service);
  }
}
