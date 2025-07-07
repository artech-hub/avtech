import { Injectable } from '@angular/core';
import { Title, Meta } from '@angular/platform-browser';
import { Router } from '@angular/router';

export interface SEOData {
  title: string;
  description: string;
  keywords: string;
  image?: string;
  url?: string;
  type?: string;
  author?: string;
}

@Injectable({
  providedIn: 'root'
})
export class SeoService {
  private readonly defaultSEO: SEOData = {
    title: 'AvTech Company - Web Development, Mobile Apps, Cloud Solutions & Digital Marketing Services',
    description: 'Professional web development, mobile app development, cloud solutions, digital marketing, UI/UX design, and IT consulting services. Transform your business with our expert technology solutions.',
    keywords: 'web development, mobile app development, cloud solutions, digital marketing, UI UX design, IT consulting, software development, responsive websites, mobile applications, cloud computing, SEO services, digital transformation, technology consulting',
    image: 'https://avtechcompany.in/assets/avtech-logo.jpg',
    url: 'https://avtechcompany.in',
    type: 'website',
    author: 'AvTech Company'
  };

  constructor(
    private titleService: Title,
    private metaService: Meta,
    private router: Router
  ) {}

  updateSEO(seoData: Partial<SEOData>): void {
    const data = { ...this.defaultSEO, ...seoData };
    
    // Update title
    this.titleService.setTitle(data.title);
    
    // Update basic meta tags
    this.updateOrCreateMetaTag('description', data.description);
    this.updateOrCreateMetaTag('keywords', data.keywords);
    this.updateOrCreateMetaTag('author', data.author || this.defaultSEO.author!);
    this.updateOrCreateMetaTag('robots', 'index, follow, max-snippet:-1, max-image-preview:large, max-video-preview:-1');
    
    // Update Open Graph meta tags
    this.updateOrCreateMetaTag('og:title', data.title, 'property');
    this.updateOrCreateMetaTag('og:description', data.description, 'property');
    this.updateOrCreateMetaTag('og:image', data.image || this.defaultSEO.image!, 'property');
    this.updateOrCreateMetaTag('og:url', data.url || this.defaultSEO.url!, 'property');
    this.updateOrCreateMetaTag('og:type', data.type || 'website', 'property');
    this.updateOrCreateMetaTag('og:site_name', 'AvTech Company', 'property');
    this.updateOrCreateMetaTag('og:locale', 'en_US', 'property');
    
    // Update Twitter meta tags
    this.updateOrCreateMetaTag('twitter:card', 'summary_large_image', 'name');
    this.updateOrCreateMetaTag('twitter:title', data.title, 'name');
    this.updateOrCreateMetaTag('twitter:description', data.description, 'name');
    this.updateOrCreateMetaTag('twitter:image', data.image || this.defaultSEO.image!, 'name');
    this.updateOrCreateMetaTag('twitter:url', data.url || this.defaultSEO.url!, 'name');
    
    // Update canonical URL
    this.updateCanonicalUrl(data.url || this.defaultSEO.url!);
  }

  private updateOrCreateMetaTag(name: string, content: string, attribute: string = 'name'): void {
    const selector = `${attribute}="${name}"`;
    const existingTag = this.metaService.getTag(selector);
    
    if (existingTag) {
      this.metaService.updateTag({ [attribute]: name, content });
    } else {
      this.metaService.addTag({ [attribute]: name, content });
    }
  }

  private updateCanonicalUrl(url: string): void {
    // Remove existing canonical link
    const existingCanonical = document.querySelector('link[rel="canonical"]');
    if (existingCanonical) {
      existingCanonical.remove();
    }
    
    // Add new canonical link
    const canonicalLink = document.createElement('link');
    canonicalLink.rel = 'canonical';
    canonicalLink.href = url;
    document.head.appendChild(canonicalLink);
  }

  generateStructuredData(type: string = 'Organization'): void {
    const existingScript = document.querySelector('script[type="application/ld+json"]');
    if (existingScript) {
      existingScript.remove();
    }

    let structuredData: any;

    switch (type) {
      case 'Organization':
        structuredData = {
          "@context": "https://schema.org",
          "@type": "Organization",
          "name": "AvTech Company",
          "url": "https://avtechcompany.in",
          "logo": "https://avtechcompany.in/assets/avtech-logo.jpg",
          "description": "Professional web development, mobile app development, cloud solutions, digital marketing, UI/UX design, and IT consulting services.",
          "address": {
            "@type": "PostalAddress",
            "addressCountry": "IN"
          },
          "contactPoint": {
            "@type": "ContactPoint",
            "telephone": "+91-XXX-XXX-XXXX",
            "contactType": "customer service"
          },
          "sameAs": [
            "https://facebook.com/avtechcompany",
            "https://twitter.com/avtechcompany",
            "https://linkedin.com/company/avtechcompany"
          ],
          "offers": {
            "@type": "Offer",
            "name": "Web Development Services",
            "description": "Custom web development, mobile app development, cloud solutions, digital marketing, UI/UX design, and IT consulting services."
          }
        };
        break;
      case 'Service':
        structuredData = {
          "@context": "https://schema.org",
          "@type": "Service",
          "name": "Web Development Services",
          "provider": {
            "@type": "Organization",
            "name": "AvTech Company"
          },
          "description": "Professional web development, mobile app development, cloud solutions, digital marketing, UI/UX design, and IT consulting services."
        };
        break;
    }

    const script = document.createElement('script');
    script.type = 'application/ld+json';
    script.text = JSON.stringify(structuredData);
    document.head.appendChild(script);
  }

  // SEO configurations for different pages
  getHomeSEO(): SEOData {
    return {
      title: 'AvTech Company - Premier Web Development, Mobile Apps & Cloud Solutions',
      description: 'Transform your business with AvTech Company\'s expert web development, mobile app development, cloud solutions, digital marketing, UI/UX design, and IT consulting services. Get cutting-edge technology solutions today.',
      keywords: 'web development company, mobile app development, cloud solutions, digital marketing agency, UI UX design services, IT consulting, software development, custom web applications, mobile applications, cloud computing services, SEO optimization, digital transformation, technology consulting India',
      url: 'https://avtechcompany.in/'
    };
  }

  getServicesSEO(): SEOData {
    return {
      title: 'Our Services - Web Development, Mobile Apps, Cloud Solutions | AvTech Company',
      description: 'Explore AvTech Company\'s comprehensive technology services: Custom web development, mobile app development, cloud solutions, digital marketing, UI/UX design, and IT consulting. Professional solutions for your business growth.',
      keywords: 'web development services, mobile app development services, cloud solutions, digital marketing services, UI UX design, IT consulting services, custom software development, responsive web design, mobile application development, cloud computing, SEO services, digital marketing agency',
      url: 'https://avtechcompany.in/services'
    };
  }

  getAboutSEO(): SEOData {
    return {
      title: 'About AvTech Company - Expert Technology Solutions Provider',
      description: 'Learn about AvTech Company, a leading provider of web development, mobile app development, cloud solutions, digital marketing, and IT consulting services. Our expert team delivers innovative technology solutions.',
      keywords: 'about avtech company, technology solutions provider, web development team, mobile app developers, cloud solutions experts, digital marketing professionals, IT consulting firm',
      url: 'https://avtechcompany.in/about'
    };
  }

  getContactSEO(): SEOData {
    return {
      title: 'Contact AvTech Company - Get Your Free Technology Consultation',
      description: 'Contact AvTech Company for web development, mobile app development, cloud solutions, digital marketing, and IT consulting services. Get your free consultation today and transform your business.',
      keywords: 'contact avtech company, web development consultation, mobile app development quote, cloud solutions consultation, digital marketing services, IT consulting, free technology consultation',
      url: 'https://avtechcompany.in/contact'
    };
  }

  getBlogSEO(): SEOData {
    return {
      title: 'Technology Blog - Web Development, Mobile Apps & Digital Marketing Tips',
      description: 'Stay updated with the latest trends in web development, mobile app development, cloud solutions, digital marketing, and technology. Read expert insights and tips from AvTech Company.',
      keywords: 'technology blog, web development blog, mobile app development tips, cloud solutions insights, digital marketing trends, technology news, software development articles',
      url: 'https://avtechcompany.in/blog'
    };
  }

  getCareerSEO(): SEOData {
    return {
      title: 'Careers at AvTech Company - Join Our Technology Team',
      description: 'Join AvTech Company and build your career in web development, mobile app development, cloud solutions, digital marketing, and IT consulting. Explore exciting opportunities with our growing team.',
      keywords: 'careers avtech company, web developer jobs, mobile app developer jobs, cloud solutions jobs, digital marketing jobs, IT consulting careers, technology jobs, software developer positions',
      url: 'https://avtechcompany.in/career'
    };
  }
}