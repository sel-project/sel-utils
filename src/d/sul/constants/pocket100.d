module sul.constants.pocket100;

import sul.types.var;

static struct Constants {

	static struct MovePlayer {

		static struct mode {

			enum ubyte reset = 1;
			enum ubyte normal = 0;
			enum ubyte rotation = 2;

		}

	}

	static struct PlayStatus {

		static struct status {

			enum uint spawned = 3;
			enum uint outdatedServer = 2;
			enum uint invalidTenant = 4;
			enum uint editionMismatch = 5;
			enum uint outdatedClient = 1;
			enum uint ok = 0;

		}

	}

	static struct Login {

		static struct edition {

			enum ubyte education = 1;
			enum ubyte classic = 0;

		}

	}

	static struct LevelEvent {

		static struct eventId {

			enum int stopThunder = 3004;
			enum int startRain = 3001;
			enum int addParticle = 16384;
			enum int stopRain = 3003;
			enum int playersSleeping = 9800;
			enum int startThunder = 3002;
			enum int setData = 4000;

		}

	}

	static struct PlayerAction {

		static struct action {

			enum int stopBreak = 2;
			enum int dimensionChange = 13;
			enum int startSneak = 11;
			enum int stopSprint = 10;
			enum int jump = 8;
			enum int stopSleeping = 6;
			enum int abortBreak = 1;
			enum int stopSneak = 12;
			enum int startBreak = 0;
			enum int startSprint = 9;
			enum int abortDimensionChange = 14;
			enum int respawn = 7;
			enum int stopGliding = 16;
			enum int releaseItem = 5;
			enum int startGliding = 15;

		}

	}

	static struct DropItem {

		static struct type {

			enum ubyte drop = 0;

		}

	}

	static struct MobEffect {

		static struct eventId {

			enum remove = 3;
			enum modify = 2;
			enum add = 1;

		}

	}

	static struct BossEvent {

		static struct event {

			enum uint remove = 2;
			enum uint update = 1;
			enum uint add = 0;

		}

	}

	static struct EntityEvent {

		static struct eventId {

			enum ubyte tameFail = 6;
			enum ubyte fishHookHook = 13;
			enum ubyte deathAnimation = 3;
			enum ubyte eatGrassAnimation = 10;
			enum ubyte tameSuccess = 7;
			enum ubyte fishHookBubbles = 11;
			enum ubyte shakeWet = 8;
			enum ubyte useItem = 9;
			enum ubyte hurtAnimation = 2;
			enum ubyte ambientSound = 16;
			enum ubyte fishHookTease = 14;
			enum ubyte respawn = 17;
			enum ubyte fishHookPosition = 12;
			enum ubyte squidInkCloud = 15;

		}

	}

	static struct UpdateBlock {

		static struct flagsAndMeta {

			enum uint priority = 8;
			enum uint nographic = 4;
			enum uint neighbours = 1;
			enum uint network = 2;

		}

	}

	static struct Interact {

		static struct action {

			enum ubyte hover = 4;
			enum ubyte interact = 2;
			enum ubyte leaveVehicle = 3;
			enum ubyte attack = 1;

		}

	}

	static struct Animate {

		static struct action {

			enum int wakeUp = 3;
			enum int breaking = 1;

		}

	}

	static struct ContainerSetContent {

		static struct window {

			enum ubyte armor = 120;
			enum ubyte creative = 121;
			enum ubyte inventory = 0;

		}

	}

	static struct AdventureSettings {

		static struct flags {

			enum uint autoJump = 32;
			enum uint pvpDisabled = 2;
			enum uint flying = 1024;
			enum uint mvpDisabled = 8;
			enum uint immutableWorld = 1;
			enum uint evpDisabled = 16;
			enum uint noClip = 256;
			enum uint allowFlight = 64;
			enum uint pvmDisabled = 4;

		}

		static struct permissions {

			enum uint operator = 1;
			enum uint automation = 3;
			enum uint host = 2;
			enum uint user = 0;
			enum uint admin = 4;

		}

	}

	static struct SetEntityLink {

		static struct type {

			enum ubyte remove = 1;
			enum ubyte add = 0;

		}

	}

}