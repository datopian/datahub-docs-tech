# DataHub API

The API provides a range of endpoints to query and manage the platform.

You can explore the API via the docs below.

<div id="swagger-ui"></div>
<script src="../../js/dist/swagger-ui-bundle.js"> </script>
<script src="../../js/dist/swagger-ui-standalone-preset.js"> </script>
<script>
window.onload = function() {
  // Build a system
  const ui = SwaggerUIBundle({
    url: "https://staging.datapackaged.com/api/swagger.json",
    dom_id: '#swagger-ui',
    validatorUrl : null,
    presets: [
      SwaggerUIBundle.presets.apis,
      SwaggerUIStandalonePreset
    ],
    plugins: [
      SwaggerUIBundle.plugins.DownloadUrl
    ],
    layout: "StandaloneLayout"
  })

  window.ui = ui
}
</script>
