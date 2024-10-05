#!/usr/bin/env python3
from notifypy import Notify

sleep_alarm = Notify(
    default_notification_title="Time to go to sleep!",
    default_notification_message="Staying up at any time later would be diabolically catastrophic my hombre. Go to bed right now!",
    default_notification_application_name="Your stupid alarm clock",
    default_notification_icon="icon.gif",
    default_notification_audio="sound.wav"
)

if __name__ == "__main__":
    sleep_alarm.send()
