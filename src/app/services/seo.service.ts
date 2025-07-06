import { Injectable } from '@angular/core';
import { Meta, Title } from '@angular/platform-browser';
import { SEO_CONFIG } from '../config/seo.config';

@Injectable({
  providedIn: 'root'
})
export class SeoService {

  constructor(private meta: Meta, private titleService: Title) { }

  updateTitle(title: string) {
    this.titleService.setTitle(title);
  }

  updateMetaTags(tags: { [key: string]: string }) {
    Object.keys(tags).forEach(key => {
      this.meta.updateTag({ name: key, content: tags[key] });
    });
  }

  updateOpenGraphTags(tags: { [key: string]: string }) {
    Object.keys(tags).forEach(key => {
      this.meta.updateTag({ property: `og:${key}`, content: tags[key] });
    });
  }

  updateTwitterTags(tags: { [key: string]: string }) {
    Object.keys(tags).forEach(key => {
      this.meta.updateTag({ name: `twitter:${key}`, content: tags[key] });
    });
  }

  updateCanonicalUrl(url: string) {
    const link: HTMLLinkElement = document.querySelector('link[rel="canonical"]') || document.createElement('link');
    link.setAttribute('rel', 'canonical');
    link.setAttribute('href', url);
    document.head.appendChild(link);
  }

  updateStructuredData(data: any) {
    // Remove existing structured data
    const existingScript = document.querySelector('script[type="application/ld+json"]');
    if (existingScript) {
      existingScript.remove();
    }
    
    const script = document.createElement('script');
    script.type = 'application/ld+json';
    script.text = JSON.stringify(data);
    document.head.appendChild(script);
  }

  // Helper method to set SEO for any page
  setSEOData(pageKey: keyof typeof SEO_CONFIG.pages) {
    const config = SEO_CONFIG.pages[pageKey];
    const fullUrl = `${SEO_CONFIG.siteUrl}${config.path}`;
    
    this.updateTitle(config.title);
    
    this.updateMetaTags({
      'description': config.description,
      'keywords': config.keywords,
      'robots': 'index, follow'
    });

    this.updateOpenGraphTags({
      'title': config.title,
      'description': config.description,
      'type': 'website',
      'url': fullUrl,
      'image': `${SEO_CONFIG.siteUrl}${SEO_CONFIG.defaultImage}`,
      'site_name': SEO_CONFIG.siteName
    });

    this.updateTwitterTags({
      'card': 'summary_large_image',
      'title': config.title,
      'description': config.description,
      'image': `${SEO_CONFIG.siteUrl}${SEO_CONFIG.defaultImage}`
    });

    this.updateCanonicalUrl(fullUrl);
  }
}
