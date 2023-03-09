export default {
  setupComponent(attrs, component) {
    const mobileView = this.site.mobileView;
    const displayField = settings.location_of_previews === "below_categories" && mobileView;
    component.set("displayField", displayField);
  },
};
