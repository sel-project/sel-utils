/*
 * This file was automatically generated by sel-utils and
 * released under the GNU General Public License version 3.
 * 
 * License: https://github.com/sel-project/sel-utils/blob/master/LICENSE
 * Repository: https://github.com/sel-project/sel-utils
 * Generated from https://github.com/sel-project/sel-utils/blob/master/xml/protocol/minecraft210.xml
 */
package sul.protocol.minecraft210.clientbound;

import sul.utils.*;

public class Entity extends Packet {

	public static final int ID = (int)40;

	public static final boolean CLIENTBOUND = true;
	public static final boolean SERVERBOUND = false;

	@Override
	public int getId() {
		return ID;
	}

	public int entityId;

	public Entity() {}

	public Entity(int entityId) {
		this.entityId = entityId;
	}

	@Override
	public int length() {
		return Buffer.varuintLength(entityId) + 1;
	}

	@Override
	public byte[] encode() {
		this._buffer = new byte[this.length()];
		this.writeVaruint(ID);
		this.writeVaruint(entityId);
		return this.getBuffer();
	}

	@Override
	public void decode(byte[] buffer) {
		this._buffer = buffer;
		this.readVaruint();
		entityId=this.readVaruint();
	}

	public static Entity fromBuffer(byte[] buffer) {
		Entity ret = new Entity();
		ret.decode(buffer);
		return ret;
	}

	@Override
	public String toString() {
		return "Entity(entityId: " + this.entityId + ")";
	}

}
