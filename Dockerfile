# Imagen base para ejecutar la aplicación
FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app
EXPOSE 8080

# Imagen base para compilar la aplicación
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
COPY ["ProductKeyAPI.csproj", "./"]
RUN dotnet restore "./ProductKeyAPI.csproj"

COPY . .
WORKDIR "/src"
RUN dotnet build "ProductKeyAPI.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "ProductKeyAPI.csproj" -c Release -o /app/publish

# Imagen final para ejecutar la aplicación
FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "ProductKeyAPI.dll"]
