namespace StatefulUploadService
{
    using System.Net.Http.Formatting;
    using Newtonsoft.Json;
    public static class FormatterConfig
    {
        public static void ConfigureFormatters(MediaTypeFormatterCollection formatters)
        {
            formatters.JsonFormatter.SerializerSettings.Formatting = Formatting.None;
        }
    }
}
