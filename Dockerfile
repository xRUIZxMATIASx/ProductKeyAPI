# Usar la imagen oficial de .NET para runtime
FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app
EXPOSE 8080

# Usar la imagen oficial de .NET SDK para compilar
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
COPY ["ProductKeyAPI.csproj", "./"]
RUN dotnet restore "./ProductKeyAPI.csproj"

COPY . .
WORKDIR "/src"
RUN dotnet build "ProductKeyAPI.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "ProductKeyAPI.csproj" -c Release -o /app/publish

# Configurar la imagen final
FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "ProductKeyAPI.dll"]