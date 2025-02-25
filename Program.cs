using System;
using System.IO;
using System.Reflection;

AppDomain.CurrentDomain.AssemblyResolve += (sender, args) =>
{
    string dllPath = Path.Combine(AppContext.BaseDirectory, "lib", "KeySecurity.dll");
    if (File.Exists(dllPath))
    {
        return Assembly.LoadFrom(dllPath);
    }
    return null;
};

var builder = WebApplication.CreateBuilder(args);

AppContext.SetSwitch("System.Text.Json.Serialization.JsonSerializerDefaults", true);
builder.Services.AddControllers();  // <-- Asegúrate de que esta línea está
var app = builder.Build();

app.UseHttpsRedirection();
app.UseAuthorization();
app.MapControllers();  // <-- IMPORTANTE: Esto debe estar para que los controladores funcionen

app.Run();
