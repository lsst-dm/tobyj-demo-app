"""Configuration definition."""

from __future__ import annotations

from pydantic import Field, SecretStr
from pydantic_settings import BaseSettings, SettingsConfigDict
from safir.logging import LogLevel, Profile

__all__ = ["Config", "config"]


class Config(BaseSettings):
    """Configuration for tobyj-demo-app."""

    model_config = SettingsConfigDict(
        env_prefix="TOBYJ_DEMO_APP_", case_sensitive=False
    )

    name: str = Field("tobyj-demo-app", title="Name of application")

    log_level: LogLevel = Field(
        LogLevel.INFO, title="Log level of the application's logger"
    )

    path_prefix: str = Field(
        "/tobyj-demo-app", title="URL prefix for application"
    )

    profile: Profile = Field(
        Profile.development, title="Application logging profile"
    )

    slack_webhook: SecretStr | None = Field(
        None,
        title="Slack webhook for alerts",
        description="If set, alerts will be posted to this Slack webhook",
    )


config = Config()
"""Configuration for tobyj-demo-app."""
