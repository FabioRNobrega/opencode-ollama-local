# --------------------------
# Stage 1 - Build environment
# --------------------------
FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src
COPY . .
RUN dotnet restore

# --------------------------
# Stage 2 - Development runtime
# --------------------------
FROM mcr.microsoft.com/dotnet/sdk:10.0

ARG APP_UID=1000
ARG APP_GID=1000

# Ensure writable home/tool/cache locations for the runtime user ids.
RUN mkdir -p /home/dev/.dotnet/tools /home/dev/.nuget/packages && \
    chown -R ${APP_UID}:${APP_GID} /home/dev

WORKDIR /app
COPY --from=build /src .

# Install dotnet tools for local development workflows.
USER ${APP_UID}:${APP_GID}
ENV DOTNET_CLI_HOME=/home/dev
ENV PATH="${PATH}:/home/dev/.dotnet/tools"
RUN dotnet tool install --global dotnet-ef --version 10.* && \
    dotnet tool install --global dotnet-aspnet-codegenerator --version 10.*

ENV ASPNETCORE_URLS=http://+:8080
ENV ASPNETCORE_ENVIRONMENT=Development
ENV NUGET_PACKAGES=/home/dev/.nuget/packages

CMD ["dotnet", "watch", "run", "--urls=http://0.0.0.0:8080"]
