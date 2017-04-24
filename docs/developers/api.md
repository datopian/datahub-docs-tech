# DataHub API

The DataHub API is a Python app that provides a range of API endpoints to query an DataHub database.

Try out the API using the Swagger interactive interface.

<div id="swagger-ui"></div>
<script src="../../js/dist/swagger-ui-bundle.js"> </script>
<script src="../../js/dist/swagger-ui-standalone-preset.js"> </script>
<script>
window.onload = function() {
  // Build a system
  const ui = SwaggerUIBundle({
    url: "https://staging.datapackaged.com/spec",
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
