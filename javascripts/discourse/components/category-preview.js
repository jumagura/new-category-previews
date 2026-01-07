import Component from "@glimmer/component";
import { inject as service } from "@ember/service";

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
        console.error(
          "CategoryPreview - Error parsing settings.categories:",
          e,
        );
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
}
