/*
 * This file has been automatically generated by sel-utils and
 * released under the GNU General Public License version 3.
 *
 * License: https://github.com/sel-project/sel-utils/blob/master/LICENSE
 * Repository: https://github.com/sel-project/sel-utils
 * Generator: https://github.com/sel-project/sel-utils/blob/master/xml/protocol/minecraft109.xml
 */
package sul.protocol.minecraft109.clientbound;

import java.util.UUID;

import sul.protocol.minecraft109.types.*;
import sul.utils.*;

class ChangeGameState extends Packet {

	public final static int ID = (int)30;

	public final static boolean CLIENTBOUND = true;
	public final static boolean SERVERBOUND = false;

	// reason
	public static immutable byte INVALID_BED = 0;
	public static immutable byte END_RAINING = 1;
	public static immutable byte BEGIN_RAINING = 2;
	public static immutable byte CHANGE_GAMEMODE = 3;
	public static immutable byte EXIT_END = 4;
	public static immutable byte DEMO_MESSAGE = 5;
	public static immutable byte ARROW_HITTING_PLAYER = 6;
	public static immutable byte FADE_VALUE = 7;
	public static immutable byte FADE_TIME = 8;
	public static immutable byte PLAY_ELDER_GUARDIAN_MOB_APPEARANCE = 10;

	// value
	public static immutable float SURVIVAL = 0;
	public static immutable float CREATIVE = 1;
	public static immutable float ADVENTURE = 2;
	public static immutable float SPECTATOR = 3;
	public static immutable float RESPAWN_IMMEDIATELY = 0;
	public static immutable float RESPAWN_AFTER_CREDITS = 1;
	public static immutable float SHOW_DEMO_SCREEN = 0;
	public static immutable float TELL_MOVEMENT_CONTROLS = 101;
	public static immutable float TELL_JUMP_CONTROLS = 102;
	public static immutable float TELL_INVENTORY_CONTROLS = 103;
	public static immutable float BRIGHT = 0;
	public static immutable float DARK = 1;

	public byte reason;
	public float value;

	@Override
	public int length() {
	}

	@Override
	public byte[] encode() {
		this.buffer = new byte[this.length()];
		this.index = 0;
		this.writeVaruint(ID);
		this.writeByteB(reason);
		this.writeFloatB(value);
		return this.buffer;
	}

	@Override
	public void decode(byte[] buffer) {
		this.buffer = buffer;
		this.index = 0;
	}

}
