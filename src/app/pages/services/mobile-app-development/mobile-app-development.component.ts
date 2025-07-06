import { Component, OnInit } from '@angular/core';
import { RouterLink } from '@angular/router';
import { SeoService } from '../../../services/seo.service';

@Component({
  selector: 'app-mobile-app-development',
  standalone: true,
  imports: [RouterLink],
  templateUrl: './mobile-app-development.component.html',
  styleUrl: './mobile-app-development.component.css'
})
export class MobileAppDevelopmentComponent implements OnInit {

  constructor(private seoService: SeoService) { }

  ngOnInit() {
    this.seoService.setSEOData('mobileApps');
  }
}
