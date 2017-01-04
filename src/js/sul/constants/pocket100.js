const Constants = {

	MovePlayer: {

		mode: {

			RESET: 1,
			NORMAL: 0,
			ROTATION: 2,

		},

	},

	PlayStatus: {

		status: {

			SPAWNED: 3,
			OUTDATED_SERVER: 2,
			INVALID_TENANT: 4,
			EDITION_MISMATCH: 5,
			OUTDATED_CLIENT: 1,
			OK: 0,

		},

	},

	Login: {

		edition: {

			EDUCATION: 1,
			CLASSIC: 0,

		},

	},

	LevelEvent: {

		eventId: {

			STOP_THUNDER: 3004,
			START_RAIN: 3001,
			ADD_PARTICLE: 16384,
			STOP_RAIN: 3003,
			PLAYERS_SLEEPING: 9800,
			START_THUNDER: 3002,
			SET_DATA: 4000,

		},

	},

	PlayerAction: {

		action: {

			STOP_BREAK: 2,
			DIMENSION_CHANGE: 13,
			START_SNEAK: 11,
			STOP_SPRINT: 10,
			JUMP: 8,
			STOP_SLEEPING: 6,
			ABORT_BREAK: 1,
			STOP_SNEAK: 12,
			START_BREAK: 0,
			START_SPRINT: 9,
			ABORT_DIMENSION_CHANGE: 14,
			RESPAWN: 7,
			STOP_GLIDING: 16,
			RELEASE_ITEM: 5,
			START_GLIDING: 15,

		},

	},

	DropItem: {

		type: {

			DROP: 0,

		},

	},

	MobEffect: {

		eventId: {

			REMOVE: 3,
			MODIFY: 2,
			ADD: 1,

		},

	},

	BossEvent: {

		event: {

			REMOVE: 2,
			UPDATE: 1,
			ADD: 0,

		},

	},

	EntityEvent: {

		eventId: {

			TAME_FAIL: 6,
			FISH_HOOK_HOOK: 13,
			DEATH_ANIMATION: 3,
			EAT_GRASS_ANIMATION: 10,
			TAME_SUCCESS: 7,
			FISH_HOOK_BUBBLES: 11,
			SHAKE_WET: 8,
			USE_ITEM: 9,
			HURT_ANIMATION: 2,
			AMBIENT_SOUND: 16,
			FISH_HOOK_TEASE: 14,
			RESPAWN: 17,
			FISH_HOOK_POSITION: 12,
			SQUID_INK_CLOUD: 15,

		},

	},

	UpdateBlock: {

		flagsAndMeta: {

			PRIORITY: 8,
			NOGRAPHIC: 4,
			NEIGHBOURS: 1,
			NETWORK: 2,

		},

	},

	Interact: {

		action: {

			HOVER: 4,
			INTERACT: 2,
			LEAVE_VEHICLE: 3,
			ATTACK: 1,

		},

	},

	Animate: {

		action: {

			WAKE_UP: 3,
			BREAKING: 1,

		},

	},

	ContainerSetContent: {

		window: {

			ARMOR: 120,
			CREATIVE: 121,
			INVENTORY: 0,

		},

	},

	AdventureSettings: {

		flags: {

			AUTO_JUMP: 32,
			PVP_DISABLED: 2,
			FLYING: 1024,
			MVP_DISABLED: 8,
			IMMUTABLE_WORLD: 1,
			EVP_DISABLED: 16,
			NO_CLIP: 256,
			ALLOW_FLIGHT: 64,
			PVM_DISABLED: 4,

		},

		permissions: {

			OPERATOR: 1,
			AUTOMATION: 3,
			HOST: 2,
			USER: 0,
			ADMIN: 4,

		},

	},

	SetEntityLink: {

		type: {

			REMOVE: 1,
			ADD: 0,

		},

	},

}
