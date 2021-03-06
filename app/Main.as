﻿package {
	import fl.video.*;
	import flash.utils.*;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.*;
	import flash.external.ExternalInterface;
	import flash.text.TextField;
	import flash.utils.Timer;
	import flash.text.TextFieldType;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.system.Security;

	public class Main extends MovieClip {
		private var output: TextField;

		public function Main() {
			Security.allowDomain("*");
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}

		private function addedToStageHandler(event: Event): void {
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);


			output = new TextField();
			output.y = 25;
			output.width = 450;
			output.height = 325;
			output.multiline = true;
			output.wordWrap = true;
			output.border = true;
			output.text = "Initializing...\n";
			output.textColor = 0xFF0000;
			//addChild(output);

			if (ExternalInterface.available) {
				try {
					output.appendText("Adding callback...\n");
					ExternalInterface.addCallback("sendToActionScript", receivedFromJavaScript);
					if (checkJavaScriptReady()) {
						output.appendText("JavaScript is ready.\n");
					} else {
						output.appendText("JavaScript is not ready, creating timer.\n");
						var readyTimer: Timer = new Timer(100, 0);
						readyTimer.addEventListener(TimerEvent.TIMER, timerHandler);
						readyTimer.start();
					}
				} catch (error: SecurityError) {
					output.appendText("A SecurityError occurred: " + error.message + "\n");
				} catch (error: Error) {
					output.appendText("An Error occurred: " + error.message + "\n");
				}
			} else {
				output.appendText("External interface is not available for this container.");
			}
			stage.addEventListener(Event.ENTER_FRAME, playing);
			gotoAndPlay('loop_start');
			//gotoAndPlay('skull_open');
		}

		private function playing(evt: Event): void {
			if (currentLabel == 'loop_end') {
				gotoAndPlay('loop_start');
			}
		}

		private function receivedFromJavaScript(value: String): void {
			output.appendText("JavaScript says: " + value + "\n");
			copy.copy.text = value;
			gotoAndPlay('skull_open');
		}

		private function checkJavaScriptReady(): Boolean {
			var isReady: Boolean = ExternalInterface.call("isReady");
			return isReady;
		}

		private function timerHandler(event: TimerEvent): void {
			output.appendText("Checking JavaScript status...\n");
			var isReady: Boolean = checkJavaScriptReady();
			if (isReady) {
				output.appendText("JavaScript is ready.\n");
				output.appendText("ExternalInterface.objectID = " + ExternalInterface.objectID + "\n");
				Timer(event.target).stop();
			}
		}
	}
}