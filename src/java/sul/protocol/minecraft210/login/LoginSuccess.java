/*
 * This file was automatically generated by sel-utils and
 * released under the GNU General Public License version 3.
 * 
 * License: https://github.com/sel-project/sel-utils/blob/master/LICENSE
 * Repository: https://github.com/sel-project/sel-utils
 * Generated from https://github.com/sel-project/sel-utils/blob/master/xml/protocol/minecraft210.xml
 */
package sul.protocol.minecraft210.login;

import java.nio.charset.StandardCharsets;

import sul.utils.*;

public class LoginSuccess extends Packet {

	public static final int ID = (int)2;

	public static final boolean CLIENTBOUND = true;
	public static final boolean SERVERBOUND = false;

	@Override
	public int getId() {
		return ID;
	}

	public String uuid;
	public String username;

	public LoginSuccess() {}

	public LoginSuccess(String uuid, String username) {
		this.uuid = uuid;
		this.username = username;
	}

	@Override
	public int length() {
		return Buffer.varuintLength(uuid.getBytes(StandardCharsets.UTF_8).length) + uuid.getBytes(StandardCharsets.UTF_8).length + Buffer.varuintLength(username.getBytes(StandardCharsets.UTF_8).length) + username.getBytes(StandardCharsets.UTF_8).length + 1;
	}

	@Override
	public byte[] encode() {
		this._buffer = new byte[this.length()];
		this.writeVaruint(ID);
		byte[] dvz=uuid.getBytes(StandardCharsets.UTF_8); this.writeVaruint((int)dvz.length); this.writeBytes(dvz);
		byte[] dnc5bu=username.getBytes(StandardCharsets.UTF_8); this.writeVaruint((int)dnc5bu.length); this.writeBytes(dnc5bu);
		return this.getBuffer();
	}

	@Override
	public void decode(byte[] buffer) {
		this._buffer = buffer;
		this.readVaruint();
		int bvdvz=this.readVaruint(); uuid=new String(this.readBytes(bvdvz), StandardCharsets.UTF_8);
		int bvdnc5bu=this.readVaruint(); username=new String(this.readBytes(bvdnc5bu), StandardCharsets.UTF_8);
	}

	public static LoginSuccess fromBuffer(byte[] buffer) {
		LoginSuccess ret = new LoginSuccess();
		ret.decode(buffer);
		return ret;
	}

	@Override
	public String toString() {
		return "LoginSuccess(uuid: " + this.uuid + ", username: " + this.username + ")";
	}

}
