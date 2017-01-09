/*
 * This file has been automatically generated by sel-utils and
 * released under the GNU General Public License version 3.
 *
 * License: https://github.com/sel-project/sel-utils/blob/master/LICENSE
 * Repository: https://github.com/sel-project/sel-utils
 * Generator: https://github.com/sel-project/sel-utils/blob/master/xml/protocol/minecraft316.xml
 */
package sul.protocol.minecraft316.login;

import java.util.UUID;

import sul.protocol.minecraft316.types.*;
import sul.utils.*;

class EncryptionRequest extends Packet {

	public final static int ID = (int)1;

	public final static boolean CLIENTBOUND = true;
	public final static boolean SERVERBOUND = false;

	public String serverId;
	public byte[] publicKey;
	public byte[] verifyToken;

	@Override
	public int length() {
	}

	@Override
	public byte[] encode() {
		this.buffer = new byte[this.length()];
		this.index = 0;
		this.writeVaruint(ID);
		byte[] c2VydmVySWQ=serverId.getBytes("UTF-8"); this.writeVaruint((int)c2VydmVySWQ.length); this.writeBytes(c2VydmVySWQ);
		this.writeVaruint((int)publicKey.length); for(ubyte cHVibGljS2V5:publicKey){ this.writeByteB(cHVibGljS2V5); }
		this.writeVaruint((int)verifyToken.length); for(ubyte dmVyaWZ5VG9rZW4:verifyToken){ this.writeByteB(dmVyaWZ5VG9rZW4); }
		return this.buffer;
	}

	@Override
	public void decode(byte[] buffer) {
		this.buffer = buffer;
		this.index = 0;
	}

}
