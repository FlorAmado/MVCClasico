# 1. Etapa de construcción
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copiamos todos los archivos
COPY . .

# Restauramos y compilamos apuntando al archivo directamente
RUN dotnet restore "MVCClasico.csproj"
RUN dotnet publish "MVCClasico.csproj" -c Release -o /app/publish /p:UseAppHost=false

# 2. Etapa de ejecución
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app

EXPOSE 8080

COPY --from=build /app/publish .

# Arrancamos la app
ENTRYPOINT ["dotnet", "MVCClasico.dll"]