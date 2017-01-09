/*
 * This file has been automatically generated by sel-utils and
 * released under the GNU General Public License version 3.
 *
 * License: https://github.com/sel-project/sel-utils/blob/master/LICENSE
 * Repository: https://github.com/sel-project/sel-utils
 * Generator: https://github.com/sel-project/sel-utils/blob/master/xml/protocol/minecraft47.xml
 */
package sul.protocol.minecraft47.clientbound;

import java.util.UUID;

import sul.protocol.minecraft47.types.*;
import sul.utils.*;

class Teams extends Packet {

	public final static int ID = (int)62;

	public final static boolean CLIENTBOUND = true;
	public final static boolean SERVERBOUND = false;

	public String name;
	public byte mode;

	@Override
	public int length() {
	}

	@Override
	public byte[] encode() {
		this.buffer = new byte[this.length()];
		this.index = 0;
		this.writeVaruint(ID);
		byte[] bmFtZQ=name.getBytes("UTF-8"); this.writeVaruint((int)bmFtZQ.length); this.writeBytes(bmFtZQ);
		this.writeByteB(mode);
		return this.buffer;
	}

	@Override
	public void decode(byte[] buffer) {
		this.buffer = buffer;
		this.index = 0;
	}

	public static class CreateTeam extends Teams {

	}

	public static class RemoveTeam extends Teams {

	}

	public static class UpdateTeamInfo extends Teams {

	}

	public static class AddPlayers extends Teams {

	}

	public static class RemovePlayers extends Teams {

	}

}
