import Component from "@glimmer/component";
import { service } from "@ember/service";
import { htmlSafe } from "@ember/template";
import CdnImg from "discourse/components/cdn-img";
import borderColor from "discourse/helpers/border-color";
import dIcon from "discourse/helpers/d-icon";

export default class CategoryPreview extends Component {
  @service site;
  @service siteSettings;

  get noCategoryStyle() {
    return this.siteSettings.category_style === "none";
  }

  get boxStyle() {
    return this.siteSettings.desktop_category_page_style === "categories_boxes";
  }

  get preview() {
    let allCategoryPreviews = [];

    if (settings.categories) {
      try {
        if (Array.isArray(settings.categories)) {
          allCategoryPreviews = settings.categories;
        } else if (
          typeof settings.categories === "string" &&
          settings.categories.trim()
        ) {
          allCategoryPreviews = JSON.parse(settings.categories);
        }
      } catch (e) {
        // silently fail if categories cannot be parsed
      }
    }

    const previewData = [];
    const categories = this.args.categories || [];

    allCategoryPreviews.forEach((data) => {
      const hasCategoryVisible = categories.some((c) => c.name === data.title);
      if (!hasCategoryVisible) {
        previewData.push({
          icon: data.icon,
          title: data.title,
          description: data.description,
          href: data.url,
          className: "preview-category",
          color: settings.border_color,
        });
      }
    });

    return previewData;
  }

  <template>
    {{#if this.preview}}
      {{#if this.site.mobileView}}
        {{#each this.preview as |p|}}
          <div
            style={{borderColor p.color}}
            class="category-list-item category {{p.className}}"
          >
            <table class="topic-list">
              <tbody>
                <tr>
                  <th class="main-link">
                    <h3>
                      {{#if p.href}}
                        <a class="category-title-link" href={{p.href}}>
                          <div class="category-text-title">
                            {{dIcon p.icon}}
                            <span class="category-name">{{p.title}}</span>
                          </div>
                        </a>
                      {{else}}
                        <div class="category-text-title">
                          {{dIcon p.icon}}
                          <span class="category-name">{{p.title}}</span>
                        </div>
                      {{/if}}
                    </h3>
                  </th>
                </tr>
                <tr class="category-description">
                  <td colspan="3">
                    <div class="category-description">{{htmlSafe
                        p.description
                      }}</div>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        {{/each}}
      {{else if this.boxStyle}}
        {{#each this.preview as |p|}}
          <div
            style={{unless this.noCategoryStyle (borderColor p.color)}}
            class="category category-box
              {{if this.noCategoryStyle 'no-category-boxes-style'}}
              {{p.className}}"
          >
            <div class="category-box-inner">
              <div class="category-logo">
                {{#if p.uploaded_logo.url}}
                  <CdnImg
                    @src={{p.uploaded_logo.url}}
                    @class="logo"
                    @width={{p.uploaded_logo.width}}
                    @height={{p.uploaded_logo.height}}
                    @alt=""
                  />
                {{/if}}
              </div>
              <div class="category-details">
                <div class="category-box-heading">
                  {{#if p.href}}
                    <a class="parent-box-link" href={{p.href}}>
                      <h3>
                        {{dIcon p.icon}}
                        {{p.title}}
                      </h3>
                    </a>
                  {{else}}
                    <h3>
                      {{dIcon p.icon}}
                      {{p.title}}
                    </h3>
                  {{/if}}
                </div>
                {{#if p.description}}
                  <div class="description">
                    {{htmlSafe p.description}}
                  </div>
                {{/if}}
              </div>
            </div>
          </div>
        {{/each}}
      {{else}}
        <div class="category-list-item category preview-main-category">
          <table class="category-list">
            <tbody>
              {{#each this.preview as |p|}}
                <tr class="category">
                  <td
                    colspan="2"
                    class="category {{if this.noCategoryStyle 'no-category-style'}}"
                    style={{unless this.noCategoryStyle (borderColor p.color)}}
                  >
                    <h3>
                      {{#if p.href}}
                        <a class="category-title-link" href={{p.href}}>
                          <div class="category-text-title">
                            {{dIcon p.icon}}
                            <span class="category-name">{{p.title}}</span>
                          </div>
                        </a>
                      {{else}}
                        <div class="category-text-title">
                          {{dIcon p.icon}}
                          <span class="category-name">{{p.title}}</span>
                        </div>
                      {{/if}}
                    </h3>
                    {{#if p.description}}
                      <div class="category-description">{{htmlSafe
                          p.description
                        }}</div>
                    {{/if}}
                  </td>
                </tr>
              {{/each}}
            </tbody>
          </table>
        </div>
      {{/if}}
    {{/if}}
  </template>
}
