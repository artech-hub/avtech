import { Component, OnInit } from '@angular/core';
import { SeoService } from '../../services/seo.service';

@Component({
  selector: 'app-home',
  imports: [],
  templateUrl: './home.component.html',
  styleUrl: './home.component.css'
})
export class HomeComponent implements OnInit {

  constructor(private seoService: SeoService) { }

  ngOnInit() {
    // Use the simplified SEO method
    this.seoService.setSEOData('home');

    // Add specific structured data for home page
    const structuredData = {
      "@context": "https://schema.org",
      "@type": "Organization",
      "name": "AVtech",
      "url": "https://avtechcompany.in",
      "logo": "https://avtechcompany.in/assets/avtech-logo.jpg",
      "description": "AVtech specializes in comprehensive digital transformation solutions across education, construction, healthcare, and enterprise sectors.",
      "founder": {
        "@type": "Person",
        "name": "Arvind Verma"
      },
      "serviceType": ["Web Development", "Mobile App Development", "Cloud Solutions", "Digital Marketing", "UI/UX Design", "Consulting"],
      "areaServed": "Worldwide",
      "contactPoint": {
        "@type": "ContactPoint",
        "contactType": "Customer Service",
        "email": "contact@avtechcompany.in",
        "url": "https://avtechcompany.in/contact"
      }
    };

    this.seoService.updateStructuredData(structuredData);
  }
}
