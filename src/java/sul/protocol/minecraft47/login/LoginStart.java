/*
 * This file has been automatically generated by sel-utils and
 * released under the GNU General Public License version 3.
 *
 * License: https://github.com/sel-project/sel-utils/blob/master/LICENSE
 * Repository: https://github.com/sel-project/sel-utils
 * Generator: https://github.com/sel-project/sel-utils/blob/master/xml/protocol/minecraft47.xml
 */
package sul.protocol.minecraft47.login;

import java.util.UUID;

import sul.protocol.minecraft47.types.*;
import sul.utils.*;

class LoginStart extends Packet {

	public final static int ID = (int)0;

	public final static boolean CLIENTBOUND = false;
	public final static boolean SERVERBOUND = true;

	public String username;

	@Override
	public int length() {
	}

	@Override
	public byte[] encode() {
		this.buffer = new byte[this.length()];
		this.index = 0;
		this.writeVaruint(ID);
		byte[] dXNlcm5hbWU=username.getBytes("UTF-8"); this.writeVaruint((int)dXNlcm5hbWU.length); this.writeBytes(dXNlcm5hbWU);
		return this.buffer;
	}

	@Override
	public void decode(byte[] buffer) {
		this.buffer = buffer;
		this.index = 0;
	}

}
