module sul.constants.hncom1;

import sul.types.var;

static struct Constants {

	static struct RemoteCommand {

		static struct origin {

			enum ubyte hub = 0;
			enum ubyte rcon = 2;
			enum ubyte externalConsole = 1;

		}

	}

	static struct Remove {

		static struct reason {

			enum ubyte left = 0;
			enum ubyte kicked = 2;
			enum ubyte timedOut = 1;
			enum ubyte transferred = 3;

		}

	}

	static struct Add {

		static struct reason {

			enum ubyte forciblyTransferred = 2;
			enum ubyte transferred = 1;
			enum ubyte firstJoin = 0;

		}

	}

	static struct Nodes {

		static struct type {

			enum ubyte remove = 1;
			enum ubyte add = 0;

		}

	}

	static struct UpdateList {

		static struct list {

			enum ubyte whitelist = 0;
			enum ubyte blacklist = 1;

		}

		static struct action {

			enum ubyte remove = 1;
			enum ubyte add = 0;

		}

	}

}
