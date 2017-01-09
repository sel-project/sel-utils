/*
 * This file has been automatically generated by sel-utils and
 * released under the GNU General Public License version 3.
 *
 * License: https://github.com/sel-project/sel-utils/blob/master/LICENSE
 * Repository: https://github.com/sel-project/sel-utils
 * Generator: https://github.com/sel-project/sel-utils/blob/master/xml/protocol/minecraft110.xml
 */
package sul.protocol.minecraft110.clientbound;

import java.util.UUID;

import sul.protocol.minecraft110.types.*;
import sul.utils.*;

class CombatEvent extends Packet {

	public final static int ID = (int)44;

	public final static boolean CLIENTBOUND = true;
	public final static boolean SERVERBOUND = false;

	public byte eventId;

	@Override
	public int length() {
	}

	@Override
	public byte[] encode() {
		this.buffer = new byte[this.length()];
		this.index = 0;
		this.writeVaruint(ID);
		this.writeByteB(eventId);
		return this.buffer;
	}

	@Override
	public void decode(byte[] buffer) {
		this.buffer = buffer;
		this.index = 0;
	}

	public static class EnterCombat extends CombatEvent {

	}

	public static class EndCombat extends CombatEvent {

	}

	public static class EntityDead extends CombatEvent {

	}

}
