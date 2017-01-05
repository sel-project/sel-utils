// This file has been automatically generated by sel-utils
// https://github.com/sel-project/sel-utils
package sul.constants;

final class Pocket100 {

	private Pocket100() {}

	public final static class MovePlayer {

		public final static class mode {

			public final static short RESET = 1;
			public final static short NORMAL = 0;
			public final static short ROTATION = 2;

		}

	}

	public final static class PlayStatus {

		public final static class status {

			public final static long SPAWNED = 3;
			public final static long OUTDATED_SERVER = 2;
			public final static long INVALID_TENANT = 4;
			public final static long EDITION_MISMATCH = 5;
			public final static long OUTDATED_CLIENT = 1;
			public final static long OK = 0;

		}

	}

	public final static class Login {

		public final static class edition {

			public final static short EDUCATION = 1;
			public final static short CLASSIC = 0;

		}

	}

	public final static class LevelEvent {

		public final static class eventId {

			public final static int STOP_THUNDER = 3004;
			public final static int START_RAIN = 3001;
			public final static int ADD_PARTICLE = 16384;
			public final static int STOP_RAIN = 3003;
			public final static int PLAYERS_SLEEPING = 9800;
			public final static int START_THUNDER = 3002;
			public final static int SET_DATA = 4000;

		}

	}

	public final static class PlayerAction {

		public final static class action {

			public final static int STOP_BREAK = 2;
			public final static int DIMENSION_CHANGE = 13;
			public final static int START_SNEAK = 11;
			public final static int STOP_SPRINT = 10;
			public final static int JUMP = 8;
			public final static int STOP_SLEEPING = 6;
			public final static int ABORT_BREAK = 1;
			public final static int STOP_SNEAK = 12;
			public final static int START_BREAK = 0;
			public final static int START_SPRINT = 9;
			public final static int ABORT_DIMENSION_CHANGE = 14;
			public final static int RESPAWN = 7;
			public final static int STOP_GLIDING = 16;
			public final static int RELEASE_ITEM = 5;
			public final static int START_GLIDING = 15;

		}

	}

	public final static class DropItem {

		public final static class type {

			public final static short DROP = 0;

		}

	}

	public final static class MobEffect {

		public final static class eventId {

			public final static int REMOVE = 3;
			public final static int MODIFY = 2;
			public final static int ADD = 1;

		}

	}

	public final static class BossEvent {

		public final static class event {

			public final static long REMOVE = 2;
			public final static long UPDATE = 1;
			public final static long ADD = 0;

		}

	}

	public final static class EntityEvent {

		public final static class eventId {

			public final static short TAME_FAIL = 6;
			public final static short FISH_HOOK_HOOK = 13;
			public final static short DEATH_ANIMATION = 3;
			public final static short EAT_GRASS_ANIMATION = 10;
			public final static short TAME_SUCCESS = 7;
			public final static short FISH_HOOK_BUBBLES = 11;
			public final static short SHAKE_WET = 8;
			public final static short USE_ITEM = 9;
			public final static short HURT_ANIMATION = 2;
			public final static short AMBIENT_SOUND = 16;
			public final static short FISH_HOOK_TEASE = 14;
			public final static short RESPAWN = 17;
			public final static short FISH_HOOK_POSITION = 12;
			public final static short SQUID_INK_CLOUD = 15;

		}

	}

	public final static class UpdateBlock {

		public final static class flagsAndMeta {

			public final static long PRIORITY = 8;
			public final static long NOGRAPHIC = 4;
			public final static long NEIGHBOURS = 1;
			public final static long NETWORK = 2;

		}

	}

	public final static class Interact {

		public final static class action {

			public final static short HOVER = 4;
			public final static short INTERACT = 2;
			public final static short LEAVE_VEHICLE = 3;
			public final static short ATTACK = 1;

		}

	}

	public final static class Animate {

		public final static class action {

			public final static int WAKE_UP = 3;
			public final static int BREAKING = 1;

		}

	}

	public final static class ContainerSetContent {

		public final static class window {

			public final static short ARMOR = 120;
			public final static short CREATIVE = 121;
			public final static short INVENTORY = 0;

		}

	}

	public final static class AdventureSettings {

		public final static class flags {

			public final static long AUTO_JUMP = 32;
			public final static long PVP_DISABLED = 2;
			public final static long FLYING = 1024;
			public final static long MVP_DISABLED = 8;
			public final static long IMMUTABLE_WORLD = 1;
			public final static long EVP_DISABLED = 16;
			public final static long NO_CLIP = 256;
			public final static long ALLOW_FLIGHT = 64;
			public final static long PVM_DISABLED = 4;

		}

		public final static class permissions {

			public final static long OPERATOR = 1;
			public final static long AUTOMATION = 3;
			public final static long HOST = 2;
			public final static long USER = 0;
			public final static long ADMIN = 4;

		}

	}

	public final static class SetEntityLink {

		public final static class type {

			public final static short REMOVE = 1;
			public final static short ADD = 0;

		}

	}

}
