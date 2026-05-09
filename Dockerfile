# 1. Etapa de construcción (Usa el SDK de .NET 8 para compilar el código)
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copiamos todos los archivos del repositorio al contenedor
COPY . .

# Restauramos dependencias y compilamos el proyecto
# Restauramos dependencias y compilamos el proyecto
RUN dotnet restore "MVCClasico/MVCClasico.csproj"
RUN dotnet publish "MVCClasico/MVCClasico.csproj" -c Release -o /app/publish /p:UseAppHost=false

# 2. Etapa de ejecución (Usa una imagen ligera solo para correr la app)
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app

# .NET 8 en contenedores usa el puerto 8080 por defecto
EXPOSE 8080

# Copiamos la app ya compilada desde la etapa anterior
COPY --from=build /app/publish .

# Comando para arrancar la app. 
# IMPORTANTE: El nombre del archivo .dll suele ser exactamente el nombre de tu proyecto.
ENTRYPOINT ["dotnet", "MVCClasico.dll"]