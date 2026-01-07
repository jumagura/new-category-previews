import Component from "@glimmer/component";
import { inject as service } from "@ember/service";
import CategoryPreview from "../../components/category-preview";

export default class CategoryPreviewBoxConnector extends Component {
  @service site;

  static shouldRender(args, context) {
    return (
      settings.location_of_previews === "below_categories" &&
      context.site.mobileView
    );
  }

  <template>
    <CategoryPreview @categories={{@outletArgs.categories}} />
  </template>
}
