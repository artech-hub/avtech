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
    title: 'AvTech Company - Affordable Web Development, Mobile Apps & Tech Solutions for Students, Colleges & Companies',
    description: 'Get professional web development, mobile app development, and custom software solutions at minimum cost. Perfect for students, colleges, and companies seeking affordable technology services with expert quality.',
    keywords: 'affordable web development, cheap mobile app development, student web development services, college technology solutions, budget website development, low cost mobile apps, affordable software development, student project development, college website design, company web solutions, minimum cost tech services, budget mobile development, cheap website design, affordable app development, student-friendly tech services',
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
          "description": "Affordable web development, mobile app development, and custom software solutions at minimum cost for students, colleges, and companies.",
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
          "offers": [
            {
              "@type": "Offer",
              "name": "Affordable Web Development Services",
              "description": "Custom web development solutions at minimum cost for students, colleges, and companies",
              "category": "Web Development",
              "priceRange": "$$"
            },
            {
              "@type": "Offer",
              "name": "Budget Mobile App Development",
              "description": "Professional mobile app development at affordable rates for all types of projects",
              "category": "Mobile Development",
              "priceRange": "$$"
            },
            {
              "@type": "Offer",
              "name": "Student Project Development",
              "description": "Special rates for student projects and academic requirements",
              "category": "Student Services",
              "priceRange": "$"
            },
            {
              "@type": "Offer",
              "name": "College Technology Solutions",
              "description": "Comprehensive technology solutions for educational institutions",
              "category": "Educational Services",
              "priceRange": "$$"
            }
          ],
          "makesOffer": {
            "@type": "Offer",
            "name": "Affordable Technology Services",
            "description": "Quality web development, mobile apps, and software solutions at minimum cost"
          }
        };
        break;
      case 'Service':
        structuredData = {
          "@context": "https://schema.org",
          "@type": "Service",
          "name": "Affordable Web Development & Mobile App Services",
          "provider": {
            "@type": "Organization",
            "name": "AvTech Company",
            "url": "https://avtechcompany.in"
          },
          "description": "Professional web development, mobile app development, and custom software solutions at minimum cost for students, colleges, and companies.",
          "serviceType": [
            "Web Development",
            "Mobile App Development",
            "Software Development",
            "Student Projects",
            "College Technology Solutions"
          ],
          "areaServed": {
            "@type": "Place",
            "name": "India"
          },
          "audience": [
            {
              "@type": "Audience",
              "name": "Students",
              "description": "College and university students needing affordable tech solutions"
            },
            {
              "@type": "Audience",
              "name": "Educational Institutions",
              "description": "Colleges and universities seeking technology services"
            },
            {
              "@type": "Audience",
              "name": "Small Companies",
              "description": "Companies looking for cost-effective technology solutions"
            }
          ]
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
      title: 'AvTech Company - Affordable Web Development & Mobile Apps for Students, Colleges & Companies',
      description: 'Professional web development, mobile app development, and custom software solutions at minimum cost. Specializing in affordable technology services for students, colleges, and companies. Get quality tech solutions without breaking the budget.',
      keywords: 'affordable web development, cheap mobile app development, student web development, college technology solutions, budget website development, low cost mobile apps, affordable software development, student project development, college website design, company web solutions, minimum cost tech services, budget mobile development, cheap website design, affordable app development, student-friendly tech services, low budget web design, affordable tech solutions, cheap software development, student web design services, college app development',
      url: 'https://avtechcompany.in/'
    };
  }

  getServicesSEO(): SEOData {
    return {
      title: 'Our Affordable Tech Services - Web Development, Mobile Apps, Software Solutions | AvTech Company',
      description: 'Explore our budget-friendly technology services: Custom web development, mobile app development, software solutions, and digital services at minimum cost. Perfect for students, colleges, and companies seeking quality tech solutions on a budget.',
      keywords: 'affordable web development services, cheap mobile app development, budget software development, student web design, college app development, low cost tech services, affordable website design, cheap mobile apps, budget web development, student project development, college technology solutions, affordable software solutions, minimum cost web design, budget mobile development, cheap tech services, affordable digital solutions',
      url: 'https://avtechcompany.in/services'
    };
  }

  getAboutSEO(): SEOData {
    return {
      title: 'About AvTech Company - Your Affordable Technology Partner for Students, Colleges & Companies',
      description: 'Learn about AvTech Company, specializing in affordable web development, mobile app development, and custom software solutions. We provide quality technology services at minimum cost for students, colleges, and companies.',
      keywords: 'about avtech company, affordable tech company, student-friendly web development, college technology partner, budget software development company, cheap web development team, affordable mobile app developers, low cost tech solutions provider',
      url: 'https://avtechcompany.in/about'
    };
  }

  getContactSEO(): SEOData {
    return {
      title: 'Contact AvTech Company - Get Free Quote for Affordable Web Development & Mobile Apps',
      description: 'Contact AvTech Company for affordable web development, mobile app development, and custom software solutions. Get your free quote today for budget-friendly technology services for students, colleges, and companies.',
      keywords: 'contact avtech company, free web development quote, affordable mobile app quote, budget software development consultation, cheap web design quote, low cost app development, student web development services, college technology solutions, affordable tech consultation',
      url: 'https://avtechcompany.in/contact'
    };
  }

  getBlogSEO(): SEOData {
    return {
      title: 'Tech Blog - Affordable Web Development Tips, Mobile App Guides & Budget Tech Solutions',
      description: 'Stay updated with affordable web development tips, mobile app development guides, and budget-friendly technology solutions. Expert insights for students, colleges, and companies seeking cost-effective tech advice.',
      keywords: 'affordable web development blog, cheap mobile app tips, budget tech solutions, student web development guides, college technology articles, low cost app development tips, affordable software development blog, budget web design tips',
      url: 'https://avtechcompany.in/blog'
    };
  }

  getCareerSEO(): SEOData {
    return {
      title: 'Careers at AvTech Company - Join Our Affordable Tech Solutions Team',
      description: 'Join AvTech Company and build your career in affordable web development, mobile app development, and budget-friendly technology solutions. Help students, colleges, and companies achieve their tech goals affordably.',
      keywords: 'careers avtech company, affordable web developer jobs, budget tech company careers, student-friendly tech jobs, college technology careers, affordable software developer positions, cheap web development jobs',
      url: 'https://avtechcompany.in/career'
    };
  }
}