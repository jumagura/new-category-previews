import Component from "@glimmer/component";
import CategoryPreview from "../../components/category-preview";

export default class CategoryPreviewConnector extends Component {
  static shouldRender(args, context) {
    return settings.location_of_previews === "above_categories";
  }

  <template>
    <CategoryPreview @categories={{@outletArgs.categories}} />
  </template>
}
