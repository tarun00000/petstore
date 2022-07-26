FROM mcr.microsoft.com/dotnet/sdk:6.0

LABEL "com.github.actions.name"="Auto Release Milestone"
LABEL "com.github.actions.description"="Drafts a GitHub rleased based"

LABEL version="0.1.0"
LABEL maintainer="tarun vats"

RUN apt-get update && apt-get install -y jq --no-install-recommends apt-utils
RUN dotnet tool install -g GitReleaseManager.Tool

ENV PATH /root/.dotnet/tools:$PATH

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
