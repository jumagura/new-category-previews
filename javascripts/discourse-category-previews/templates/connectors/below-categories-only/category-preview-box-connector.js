export default {
  setupComponent(attrs, component) {
    const displayField = settings.location_of_previews === "below_categories";
    component.set("displayField", displayField);
  },
};
