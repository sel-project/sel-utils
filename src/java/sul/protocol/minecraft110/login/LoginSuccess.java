/*
 * This file has been automatically generated by sel-utils and
 * released under the GNU General Public License version 3.
 *
 * License: https://github.com/sel-project/sel-utils/blob/master/LICENSE
 * Repository: https://github.com/sel-project/sel-utils
 * Generator: https://github.com/sel-project/sel-utils/blob/master/xml/protocol/minecraft110.xml
 */
package sul.protocol.minecraft110.login;

import java.util.UUID;

import sul.protocol.minecraft110.types.*;
import sul.utils.*;

class LoginSuccess extends Packet {

	public final static int ID = (int)2;

	public final static boolean CLIENTBOUND = true;
	public final static boolean SERVERBOUND = false;

	public String uuid;
	public String username;

	@Override
	public int length() {
	}

	@Override
	public byte[] encode() {
		this.buffer = new byte[this.length()];
		this.index = 0;
		this.writeVaruint(ID);
		byte[] dXVpZA=uuid.getBytes("UTF-8"); this.writeVaruint((int)dXVpZA.length); this.writeBytes(dXVpZA);
		byte[] dXNlcm5hbWU=username.getBytes("UTF-8"); this.writeVaruint((int)dXNlcm5hbWU.length); this.writeBytes(dXNlcm5hbWU);
		return this.buffer;
	}

	@Override
	public void decode(byte[] buffer) {
		this.buffer = buffer;
		this.index = 0;
	}

}
