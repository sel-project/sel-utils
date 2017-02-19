/*
 * This file was automatically generated by sel-utils and
 * released under the GNU General Public License version 3.
 * 
 * License: https://github.com/sel-project/sel-utils/blob/master/LICENSE
 * Repository: https://github.com/sel-project/sel-utils
 * Generated from https://github.com/sel-project/sel-utils/blob/master/xml/protocol/minecraft47.xml
 */
package sul.protocol.minecraft47.clientbound;

import sul.utils.*;

public class SpawnMob extends Packet {

	public static final int ID = (int)15;

	public static final boolean CLIENTBOUND = true;
	public static final boolean SERVERBOUND = false;

	@Override
	public int getId() {
		return ID;
	}

	public int entityId;
	public byte type;
	public Tuples.IntXYZ position = new Tuples.IntXYZ();
	public byte yaw;
	public byte pitch;
	public byte headPitch;
	public Tuples.ShortXYZ velocity = new Tuples.ShortXYZ();
	public sul.metadata.Minecraft47 metadata;

	public SpawnMob() {}

	public SpawnMob(int entityId, byte type, Tuples.IntXYZ position, byte yaw, byte pitch, byte headPitch, Tuples.ShortXYZ velocity, sul.metadata.Minecraft47 metadata) {
		this.entityId = entityId;
		this.type = type;
		this.position = position;
		this.yaw = yaw;
		this.pitch = pitch;
		this.headPitch = headPitch;
		this.velocity = velocity;
		this.metadata = metadata;
	}

	@Override
	public int length() {
		return Buffer.varuintLength(entityId) + metadata.length() + 23;
	}

	@Override
	public byte[] encode() {
		this._buffer = new byte[this.length()];
		this.writeVaruint(ID);
		this.writeVaruint(entityId);
		this.writeBigEndianByte(type);
		this.writeBigEndianInt(position.x); this.writeBigEndianInt(position.y); this.writeBigEndianInt(position.z);
		this.writeBigEndianByte(yaw);
		this.writeBigEndianByte(pitch);
		this.writeBigEndianByte(headPitch);
		this.writeBigEndianShort(velocity.x); this.writeBigEndianShort(velocity.y); this.writeBigEndianShort(velocity.z);
		this.writeBytes(metadata.encode());
		return this.getBuffer();
	}

	@Override
	public void decode(byte[] buffer) {
		this._buffer = buffer;
		this.readVaruint();
		entityId=this.readVaruint();
		type=readBigEndianByte();
		position=new Tuples.IntXYZ(); position.x=readBigEndianInt(); position.y=readBigEndianInt(); position.z=readBigEndianInt();
		yaw=readBigEndianByte();
		pitch=readBigEndianByte();
		headPitch=readBigEndianByte();
		velocity=new Tuples.ShortXYZ(); velocity.x=readBigEndianShort(); velocity.y=readBigEndianShort(); velocity.z=readBigEndianShort();
		metadata=new sul.metadata.Minecraft47(); metadata._index=this._index; metadata.decode(this._buffer); this._index=metadata._index;
	}

	public static SpawnMob fromBuffer(byte[] buffer) {
		SpawnMob ret = new SpawnMob();
		ret.decode(buffer);
		return ret;
	}

	@Override
	public String toString() {
		return "SpawnMob(entityId: " + this.entityId + ", type: " + this.type + ", position: " + this.position.toString() + ", yaw: " + this.yaw + ", pitch: " + this.pitch + ", headPitch: " + this.headPitch + ", velocity: " + this.velocity.toString() + ", metadata: " + this.metadata.toString() + ")";
	}

}
