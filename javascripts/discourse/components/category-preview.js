import Component from "@ember/component";
import { equal } from "@ember/object/computed";
import discourseComputed from "discourse-common/utils/decorators";

const allCategoryPreviews = settings.categories ? JSON.parse(settings.categories) : [];

export default Component.extend({
  noCategoryStyle: equal("siteSettings.category_style", "none"),
  boxStyle: equal("siteSettings.desktop_category_page_style", "categories_boxes"),

  @discourseComputed()
  preview() {
    const previewData = [];
    const categorySlug = this.parentView.categories.content;
    allCategoryPreviews.forEach((data) => {
      const hasCategoryVisible = categorySlug.some((c) => c.name === data.title);
      if (!hasCategoryVisible) {
        previewData.push({
          icon: data.icon,
          title: data.title,
          description: data.description,
          href: data.url,
          className: `preview-category`,
          color: settings.border_color,
        });
      }
    });
    return previewData;
  },
});
