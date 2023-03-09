export default {
  setupComponent(attrs, component) {
    const displayField = settings.location_of_previews === "above_categories";
    component.set("displayField", displayField);
  },
};
