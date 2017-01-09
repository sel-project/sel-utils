/*
 * This file has been automatically generated by sel-utils and
 * released under the GNU General Public License version 3.
 *
 * License: https://github.com/sel-project/sel-utils/blob/master/LICENSE
 * Repository: https://github.com/sel-project/sel-utils
 * Generator: https://github.com/sel-project/sel-utils/blob/master/xml/protocol/minecraft315.xml
 */
package sul.protocol.minecraft315.serverbound;

import java.util.UUID;

import sul.protocol.minecraft315.types.*;
import sul.utils.*;

class SteerBoat extends Packet {

	public final static int ID = (int)17;

	public final static boolean CLIENTBOUND = false;
	public final static boolean SERVERBOUND = true;

	public boolean rightPaddleTurning;
	public boolean leftPaddleTurning;

	@Override
	public int length() {
	}

	@Override
	public byte[] encode() {
		this.buffer = new byte[this.length()];
		this.index = 0;
		this.writeVaruint(ID);
		this.writeBoolB(rightPaddleTurning);
		this.writeBoolB(leftPaddleTurning);
		return this.buffer;
	}

	@Override
	public void decode(byte[] buffer) {
		this.buffer = buffer;
		this.index = 0;
	}

}
