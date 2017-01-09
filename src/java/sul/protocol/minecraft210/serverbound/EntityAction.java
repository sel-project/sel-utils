/*
 * This file has been automatically generated by sel-utils and
 * released under the GNU General Public License version 3.
 *
 * License: https://github.com/sel-project/sel-utils/blob/master/LICENSE
 * Repository: https://github.com/sel-project/sel-utils
 * Generator: https://github.com/sel-project/sel-utils/blob/master/xml/protocol/minecraft210.xml
 */
package sul.protocol.minecraft210.serverbound;

import java.util.UUID;

import sul.protocol.minecraft210.types.*;
import sul.utils.*;

class EntityAction extends Packet {

	public final static int ID = (int)20;

	public final static boolean CLIENTBOUND = false;
	public final static boolean SERVERBOUND = true;

	// action
	public static immutable int START_SNEAKING = 0;
	public static immutable int STOP_SNEAKING = 1;
	public static immutable int LEAVE_BED = 2;
	public static immutable int START_SPRINTING = 3;
	public static immutable int STOP_SPRINTING = 4;
	public static immutable int START_HORSE_JUMP = 5;
	public static immutable int STOP_HORSE_JUMP = 6;
	public static immutable int OPEN_HORSE_INVENTORY = 7;
	public static immutable int START_ELYTRA_FLYING = 8;

	public int entityId;
	public int action;
	public int jumpBoost;

	@Override
	public int length() {
	}

	@Override
	public byte[] encode() {
		this.buffer = new byte[this.length()];
		this.index = 0;
		this.writeVaruint(ID);
		this.writeVaruint(entityId);
		this.writeVaruint(action);
		if(action==5){ this.writeVaruint(jumpBoost); }
		return this.buffer;
	}

	@Override
	public void decode(byte[] buffer) {
		this.buffer = buffer;
		this.index = 0;
	}

}
