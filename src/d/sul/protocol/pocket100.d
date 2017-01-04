module sul.protocol.pocket100;

import std.bitmanip : read, write;
import std.conv : to;
import std.uuid : UUID;
import std.system : Endian;
import std.typecons : Tuple, tuple;

import sul.types.var;

static struct Types {

	static struct Recipe {


		public void encode(ref ubyte[] buffer) {
		}

		public void decode(ref ubyte[] buffer) {
		}

	}

	static struct BlockPosition {

		public int x;
		public uint y;
		public int z;

		public void encode(ref ubyte[] buffer) {
			buffer~=varint.encode(x);
			buffer~=varuint.encode(y);
			buffer~=varint.encode(z);
		}

		public void decode(ref ubyte[] buffer) {
			x=varint.fromBuffer(buffer);
			y=varuint.fromBuffer(buffer);
			z=varint.fromBuffer(buffer);
		}

	}

	static struct Slot {

		public int id;
		public int metaAndCount;
		public ubyte[] nbt;

		public void encode(ref ubyte[] buffer) {
			buffer~=varint.encode(id);
			if(id>0){ buffer~=varint.encode(metaAndCount); }
			if(id>0){ buffer.length+=ushort.sizeof; write!(ushort, Endian.littleEndian)(buffer, nbt.length.to!ushort, buffer.length-ushort.sizeof); buffer~=nbt; }
		}

		public void decode(ref ubyte[] buffer) {
			id=varint.fromBuffer(buffer);
			if(id>0){ metaAndCount=varint.fromBuffer(buffer); }
			if(id>0){ if(buffer.length>=ushort.sizeof){ nbt.length=read!(ushort, Endian.littleEndian)(buffer); }if(buffer.length>=nbt.length){ nbt=buffer[0..nbt.length]; buffer=buffer[nbt.length..$]; } }
		}

	}

	static struct PlayerList {

		public UUID uuid;
		public long entityId;
		public string displayName;
		public Types.Skin skin;

		public void encode(ref ubyte[] buffer) {
			buffer~=uuid.data;
			buffer~=varlong.encode(entityId);
			ubyte[] ZGlzcGxheU5hbWU=cast(ubyte[])displayName; buffer~=varuint.encode(ZGlzcGxheU5hbWU.length.to!uint); buffer~=ZGlzcGxheU5hbWU;
			skin.encode(buffer);
		}

		public void decode(ref ubyte[] buffer) {
			if(buffer.length>=16){ ubyte[16] dXVpZA=buffer[0..16]; buffer=buffer[16..$]; uuid=UUID(dXVpZA); }
			entityId=varlong.fromBuffer(buffer);
			ubyte[] ZGlzcGxheU5hbWU; ZGlzcGxheU5hbWU.length=varuint.fromBuffer(buffer);if(buffer.length>=ZGlzcGxheU5hbWU.length){ ZGlzcGxheU5hbWU=buffer[0..ZGlzcGxheU5hbWU.length]; buffer=buffer[ZGlzcGxheU5hbWU.length..$]; }; displayName=cast(string)ZGlzcGxheU5hbWU;
			skin.decode(buffer);
		}

	}

	static struct Metadata {


		public void encode(ref ubyte[] buffer) {
		}

		public void decode(ref ubyte[] buffer) {
		}

	}

	static struct Attribute {

		public float min;
		public float max;
		public float value;
		public float def;
		public string name;

		public void encode(ref ubyte[] buffer) {
			buffer.length+=float.sizeof; write!(float, Endian.littleEndian)(buffer, min, buffer.length-float.sizeof);
			buffer.length+=float.sizeof; write!(float, Endian.littleEndian)(buffer, max, buffer.length-float.sizeof);
			buffer.length+=float.sizeof; write!(float, Endian.littleEndian)(buffer, value, buffer.length-float.sizeof);
			buffer.length+=float.sizeof; write!(float, Endian.littleEndian)(buffer, def, buffer.length-float.sizeof);
			ubyte[] bmFtZQ=cast(ubyte[])name; buffer~=varuint.encode(bmFtZQ.length.to!uint); buffer~=bmFtZQ;
		}

		public void decode(ref ubyte[] buffer) {
			if(buffer.length>=float.sizeof){ min=read!(float, Endian.littleEndian)(buffer); }
			if(buffer.length>=float.sizeof){ max=read!(float, Endian.littleEndian)(buffer); }
			if(buffer.length>=float.sizeof){ value=read!(float, Endian.littleEndian)(buffer); }
			if(buffer.length>=float.sizeof){ def=read!(float, Endian.littleEndian)(buffer); }
			ubyte[] bmFtZQ; bmFtZQ.length=varuint.fromBuffer(buffer);if(buffer.length>=bmFtZQ.length){ bmFtZQ=buffer[0..bmFtZQ.length]; buffer=buffer[bmFtZQ.length..$]; }; name=cast(string)bmFtZQ;
		}

	}

	static struct Pack {

		public string id;
		public string vers;
		public ulong size;

		public void encode(ref ubyte[] buffer) {
			ubyte[] aWQ=cast(ubyte[])id; buffer~=varuint.encode(aWQ.length.to!uint); buffer~=aWQ;
			ubyte[] dmVycw=cast(ubyte[])vers; buffer~=varuint.encode(dmVycw.length.to!uint); buffer~=dmVycw;
			buffer.length+=ulong.sizeof; write!(ulong, Endian.bigEndian)(buffer, size, buffer.length-ulong.sizeof);
		}

		public void decode(ref ubyte[] buffer) {
			ubyte[] aWQ; aWQ.length=varuint.fromBuffer(buffer);if(buffer.length>=aWQ.length){ aWQ=buffer[0..aWQ.length]; buffer=buffer[aWQ.length..$]; }; id=cast(string)aWQ;
			ubyte[] dmVycw; dmVycw.length=varuint.fromBuffer(buffer);if(buffer.length>=dmVycw.length){ dmVycw=buffer[0..dmVycw.length]; buffer=buffer[dmVycw.length..$]; }; vers=cast(string)dmVycw;
			if(buffer.length>=ulong.sizeof){ size=read!(ulong, Endian.bigEndian)(buffer); }
		}

	}

	static struct Skin {

		public string name;
		public ubyte[] data;

		public void encode(ref ubyte[] buffer) {
			ubyte[] bmFtZQ=cast(ubyte[])name; buffer~=varuint.encode(bmFtZQ.length.to!uint); buffer~=bmFtZQ;
			buffer~=varuint.encode(data.length.to!uint); buffer~=data;
		}

		public void decode(ref ubyte[] buffer) {
			ubyte[] bmFtZQ; bmFtZQ.length=varuint.fromBuffer(buffer);if(buffer.length>=bmFtZQ.length){ bmFtZQ=buffer[0..bmFtZQ.length]; buffer=buffer[bmFtZQ.length..$]; }; name=cast(string)bmFtZQ;
			data.length=varuint.fromBuffer(buffer);if(buffer.length>=data.length){ data=buffer[0..data.length]; buffer=buffer[data.length..$]; }
		}

	}

	static struct Chunk {


		public void encode(ref ubyte[] buffer) {
		}

		public void decode(ref ubyte[] buffer) {
		}

	}

}

static struct Packets {

	static struct Play {

		static struct ClientMagic {

			public enum ubyte packetId = 4;

			public enum bool clientbound = false;
			public enum bool serverbound = true;


			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				return this;
			}

		}

		static struct SetDifficulty {

			public enum ubyte packetId = 60;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public uint difficulty;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				buffer~=varuint.encode(difficulty);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				difficulty=varuint.fromBuffer(buffer);
				return this;
			}

		}

		static struct RequestChunkRadius {

			public enum ubyte packetId = 68;

			public enum bool clientbound = false;
			public enum bool serverbound = true;

			public int radius;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				buffer~=varint.encode(radius);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				radius=varint.fromBuffer(buffer);
				return this;
			}

		}

		static struct ChunkRadiusUpdated {

			public enum ubyte packetId = 69;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public int radius;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				buffer~=varint.encode(radius);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				radius=varint.fromBuffer(buffer);
				return this;
			}

		}

		static struct MobArmorEquipment {

			public enum ubyte packetId = 33;

			public enum bool clientbound = true;
			public enum bool serverbound = true;

			public long entityId;
			public Types.Slot helmet;
			public Types.Slot chestplate;
			public Types.Slot leggings;
			public Types.Slot boots;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				buffer~=varlong.encode(entityId);
				helmet.encode(buffer);
				chestplate.encode(buffer);
				leggings.encode(buffer);
				boots.encode(buffer);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				entityId=varlong.fromBuffer(buffer);
				helmet.decode(buffer);
				chestplate.decode(buffer);
				leggings.decode(buffer);
				boots.decode(buffer);
				return this;
			}

		}

		static struct Batch {

			public enum ubyte packetId = 6;

			public enum bool clientbound = true;
			public enum bool serverbound = true;

			public ubyte[] data;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				buffer~=varuint.encode(data.length.to!uint); buffer~=data;
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				data.length=varuint.fromBuffer(buffer);if(buffer.length>=data.length){ data=buffer[0..data.length]; buffer=buffer[data.length..$]; }
				return this;
			}

		}

		static struct BossEvent {

			public enum ubyte packetId = 75;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public long entityId;
			public uint event;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				buffer~=varlong.encode(entityId);
				buffer~=varuint.encode(event);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				entityId=varlong.fromBuffer(buffer);
				event=varuint.fromBuffer(buffer);
				return this;
			}

		}

		static struct PlayerList {

			public enum ubyte packetId = 63;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public ubyte type;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, type, buffer.length-ubyte.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				if(buffer.length>=ubyte.sizeof){ type=read!(ubyte, Endian.bigEndian)(buffer); }
				return this;
			}

			static struct Remove {

				public enum ubyte type = 1;
				public UUID[] players;

				public ubyte[] encode(bool write_id=true)() {
					ubyte[] buffer;
					static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
					buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, type, buffer.length-ubyte.sizeof);
					buffer~=varuint.encode(players.length.to!uint);foreach(cGxheWVycw;players){ buffer~=cGxheWVycw.data; }
					return buffer;
				}

				public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
					static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
					ubyte __field_value; if(buffer.length>=ubyte.sizeof){ __field_value=read!(ubyte, Endian.bigEndian)(buffer); }
					players.length=varuint.fromBuffer(buffer);foreach(ref cGxheWVycw;players){ if(buffer.length>=16){ ubyte[16] Y0d4aGVXVnljdw=buffer[0..16]; buffer=buffer[16..$]; cGxheWVycw=UUID(Y0d4aGVXVnljdw); }}
					return this;
				}

			}

			static struct Add {

				public enum ubyte type = 0;
				public Types.PlayerList[] players;

				public ubyte[] encode(bool write_id=true)() {
					ubyte[] buffer;
					static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
					buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, type, buffer.length-ubyte.sizeof);
					buffer~=varuint.encode(players.length.to!uint);foreach(cGxheWVycw;players){ cGxheWVycw.encode(buffer); }
					return buffer;
				}

				public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
					static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
					ubyte __field_value; if(buffer.length>=ubyte.sizeof){ __field_value=read!(ubyte, Endian.bigEndian)(buffer); }
					players.length=varuint.fromBuffer(buffer);foreach(ref cGxheWVycw;players){ cGxheWVycw.decode(buffer);}
					return this;
				}

			}

		}

		static struct Interact {

			public enum ubyte packetId = 34;

			public enum bool clientbound = false;
			public enum bool serverbound = true;

			public ubyte action;
			public long target;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, action, buffer.length-ubyte.sizeof);
				buffer~=varlong.encode(target);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				if(buffer.length>=ubyte.sizeof){ action=read!(ubyte, Endian.bigEndian)(buffer); }
				target=varlong.fromBuffer(buffer);
				return this;
			}

		}

		static struct TakeItemEntity {

			public enum ubyte packetId = 18;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public long entityTaken;
			public long collector;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				buffer~=varlong.encode(entityTaken);
				buffer~=varlong.encode(collector);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				entityTaken=varlong.fromBuffer(buffer);
				collector=varlong.fromBuffer(buffer);
				return this;
			}

		}

		static struct RiderJump {

			public enum ubyte packetId = 21;

			public enum bool clientbound = true;
			public enum bool serverbound = true;

			public long rider;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				buffer~=varlong.encode(rider);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				rider=varlong.fromBuffer(buffer);
				return this;
			}

		}

		static struct Camera {

			public enum ubyte packetId = 73;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public long entityId;
			public long runtimeId;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				buffer~=varlong.encode(entityId);
				buffer~=varlong.encode(runtimeId);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				entityId=varlong.fromBuffer(buffer);
				runtimeId=varlong.fromBuffer(buffer);
				return this;
			}

		}

		static struct AddPainting {

			public enum ubyte packetId = 24;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public long entityId;
			public long runtimeId;
			public Types.BlockPosition position;
			public int direction;
			public string title;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				buffer~=varlong.encode(entityId);
				buffer~=varlong.encode(runtimeId);
				position.encode(buffer);
				buffer~=varint.encode(direction);
				ubyte[] dGl0bGU=cast(ubyte[])title; buffer~=varuint.encode(dGl0bGU.length.to!uint); buffer~=dGl0bGU;
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				entityId=varlong.fromBuffer(buffer);
				runtimeId=varlong.fromBuffer(buffer);
				position.decode(buffer);
				direction=varint.fromBuffer(buffer);
				ubyte[] dGl0bGU; dGl0bGU.length=varuint.fromBuffer(buffer);if(buffer.length>=dGl0bGU.length){ dGl0bGU=buffer[0..dGl0bGU.length]; buffer=buffer[dGl0bGU.length..$]; }; title=cast(string)dGl0bGU;
				return this;
			}

		}

		static struct AddItem {

			public enum ubyte packetId = 74;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public Types.Slot item;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				item.encode(buffer);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				item.decode(buffer);
				return this;
			}

		}

		static struct ReplaceSelectedItem {

			public enum ubyte packetId = 71;

			public enum bool clientbound = false;
			public enum bool serverbound = true;

			public Types.Slot item;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				item.encode(buffer);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				item.decode(buffer);
				return this;
			}

		}

		static struct PlayStatus {

			public enum ubyte packetId = 2;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public uint status;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				buffer.length+=uint.sizeof; write!(uint, Endian.bigEndian)(buffer, status, buffer.length-uint.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				if(buffer.length>=uint.sizeof){ status=read!(uint, Endian.bigEndian)(buffer); }
				return this;
			}

		}

		static struct Explode {

			public enum ubyte packetId = 25;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public Tuple!(float, "x", float, "y", float, "z") position;
			public float radius;
			public Types.BlockPosition[] destroyedBlocks;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				buffer.length+=float.sizeof; write!(float, Endian.littleEndian)(buffer, position.x, buffer.length-float.sizeof);buffer.length+=float.sizeof; write!(float, Endian.littleEndian)(buffer, position.y, buffer.length-float.sizeof);buffer.length+=float.sizeof; write!(float, Endian.littleEndian)(buffer, position.z, buffer.length-float.sizeof);
				buffer.length+=float.sizeof; write!(float, Endian.littleEndian)(buffer, radius, buffer.length-float.sizeof);
				buffer~=varuint.encode(destroyedBlocks.length.to!uint);foreach(ZGVzdHJveWVkQmxv;destroyedBlocks){ ZGVzdHJveWVkQmxv.encode(buffer); }
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				if(buffer.length>=float.sizeof){ position.x=read!(float, Endian.littleEndian)(buffer); }if(buffer.length>=float.sizeof){ position.y=read!(float, Endian.littleEndian)(buffer); }if(buffer.length>=float.sizeof){ position.z=read!(float, Endian.littleEndian)(buffer); }
				if(buffer.length>=float.sizeof){ radius=read!(float, Endian.littleEndian)(buffer); }
				destroyedBlocks.length=varuint.fromBuffer(buffer);foreach(ref ZGVzdHJveWVkQmxv;destroyedBlocks){ ZGVzdHJveWVkQmxv.decode(buffer);}
				return this;
			}

		}

		static struct CraftingEvent {

			public enum ubyte packetId = 54;

			public enum bool clientbound = false;
			public enum bool serverbound = true;

			public ubyte window;
			public int type;
			public UUID uuid;
			public Types.Slot[] input;
			public Types.Slot[] output;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, window, buffer.length-ubyte.sizeof);
				buffer~=varint.encode(type);
				buffer~=uuid.data;
				buffer~=varuint.encode(input.length.to!uint);foreach(aW5wdXQ;input){ aW5wdXQ.encode(buffer); }
				buffer~=varuint.encode(output.length.to!uint);foreach(b3V0cHV0;output){ b3V0cHV0.encode(buffer); }
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				if(buffer.length>=ubyte.sizeof){ window=read!(ubyte, Endian.bigEndian)(buffer); }
				type=varint.fromBuffer(buffer);
				if(buffer.length>=16){ ubyte[16] dXVpZA=buffer[0..16]; buffer=buffer[16..$]; uuid=UUID(dXVpZA); }
				input.length=varuint.fromBuffer(buffer);foreach(ref aW5wdXQ;input){ aW5wdXQ.decode(buffer);}
				output.length=varuint.fromBuffer(buffer);foreach(ref b3V0cHV0;output){ b3V0cHV0.decode(buffer);}
				return this;
			}

		}

		static struct PlayerAction {

			public enum ubyte packetId = 36;

			public enum bool clientbound = false;
			public enum bool serverbound = true;

			public long entityId;
			public int action;
			public Types.BlockPosition position;
			public int face;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				buffer~=varlong.encode(entityId);
				buffer~=varint.encode(action);
				position.encode(buffer);
				buffer~=varint.encode(face);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				entityId=varlong.fromBuffer(buffer);
				action=varint.fromBuffer(buffer);
				position.decode(buffer);
				face=varint.fromBuffer(buffer);
				return this;
			}

		}

		static struct DropItem {

			public enum ubyte packetId = 46;

			public enum bool clientbound = false;
			public enum bool serverbound = true;

			public ubyte type;
			public Types.Slot item;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, type, buffer.length-ubyte.sizeof);
				item.encode(buffer);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				if(buffer.length>=ubyte.sizeof){ type=read!(ubyte, Endian.bigEndian)(buffer); }
				item.decode(buffer);
				return this;
			}

		}

		static struct AvailableCommands {

			public enum ubyte packetId = 77;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public string commands;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				ubyte[] Y29tbWFuZHM=cast(ubyte[])commands; buffer~=varuint.encode(Y29tbWFuZHM.length.to!uint); buffer~=Y29tbWFuZHM;
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				ubyte[] Y29tbWFuZHM; Y29tbWFuZHM.length=varuint.fromBuffer(buffer);if(buffer.length>=Y29tbWFuZHM.length){ Y29tbWFuZHM=buffer[0..Y29tbWFuZHM.length]; buffer=buffer[Y29tbWFuZHM.length..$]; }; commands=cast(string)Y29tbWFuZHM;
				return this;
			}

		}

		static struct UseItem {

			public enum ubyte packetId = 35;

			public enum bool clientbound = false;
			public enum bool serverbound = true;

			public Types.BlockPosition blockPosition;
			public uint hotbarSlot;
			public int face;
			public Tuple!(float, "x", float, "y", float, "z") facePosition;
			public Tuple!(float, "x", float, "y", float, "z") playerPosition;
			public int slot;
			public Types.Slot item;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				blockPosition.encode(buffer);
				buffer~=varuint.encode(hotbarSlot);
				buffer~=varint.encode(face);
				buffer.length+=float.sizeof; write!(float, Endian.littleEndian)(buffer, facePosition.x, buffer.length-float.sizeof);buffer.length+=float.sizeof; write!(float, Endian.littleEndian)(buffer, facePosition.y, buffer.length-float.sizeof);buffer.length+=float.sizeof; write!(float, Endian.littleEndian)(buffer, facePosition.z, buffer.length-float.sizeof);
				buffer.length+=float.sizeof; write!(float, Endian.littleEndian)(buffer, playerPosition.x, buffer.length-float.sizeof);buffer.length+=float.sizeof; write!(float, Endian.littleEndian)(buffer, playerPosition.y, buffer.length-float.sizeof);buffer.length+=float.sizeof; write!(float, Endian.littleEndian)(buffer, playerPosition.z, buffer.length-float.sizeof);
				buffer~=varint.encode(slot);
				item.encode(buffer);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				blockPosition.decode(buffer);
				hotbarSlot=varuint.fromBuffer(buffer);
				face=varint.fromBuffer(buffer);
				if(buffer.length>=float.sizeof){ facePosition.x=read!(float, Endian.littleEndian)(buffer); }if(buffer.length>=float.sizeof){ facePosition.y=read!(float, Endian.littleEndian)(buffer); }if(buffer.length>=float.sizeof){ facePosition.z=read!(float, Endian.littleEndian)(buffer); }
				if(buffer.length>=float.sizeof){ playerPosition.x=read!(float, Endian.littleEndian)(buffer); }if(buffer.length>=float.sizeof){ playerPosition.y=read!(float, Endian.littleEndian)(buffer); }if(buffer.length>=float.sizeof){ playerPosition.z=read!(float, Endian.littleEndian)(buffer); }
				slot=varint.fromBuffer(buffer);
				item.decode(buffer);
				return this;
			}

		}

		static struct HurtArmor {

			public enum ubyte packetId = 38;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public int health;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				buffer~=varint.encode(health);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				health=varint.fromBuffer(buffer);
				return this;
			}

		}

		static struct UpdateAttributes {

			public enum ubyte packetId = 31;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public long entityId;
			public Types.Attribute[] attributes;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				buffer~=varlong.encode(entityId);
				buffer~=varuint.encode(attributes.length.to!uint);foreach(YXR0cmlidXRlcw;attributes){ YXR0cmlidXRlcw.encode(buffer); }
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				entityId=varlong.fromBuffer(buffer);
				attributes.length=varuint.fromBuffer(buffer);foreach(ref YXR0cmlidXRlcw;attributes){ YXR0cmlidXRlcw.decode(buffer);}
				return this;
			}

		}

		static struct AddItemEntity {

			public enum ubyte packetId = 16;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public long entityId;
			public long runtimeId;
			public Types.Slot item;
			public Tuple!(float, "x", float, "y", float, "z") position;
			public Tuple!(float, "x", float, "y", float, "z") motion;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				buffer~=varlong.encode(entityId);
				buffer~=varlong.encode(runtimeId);
				item.encode(buffer);
				buffer.length+=float.sizeof; write!(float, Endian.littleEndian)(buffer, position.x, buffer.length-float.sizeof);buffer.length+=float.sizeof; write!(float, Endian.littleEndian)(buffer, position.y, buffer.length-float.sizeof);buffer.length+=float.sizeof; write!(float, Endian.littleEndian)(buffer, position.z, buffer.length-float.sizeof);
				buffer.length+=float.sizeof; write!(float, Endian.littleEndian)(buffer, motion.x, buffer.length-float.sizeof);buffer.length+=float.sizeof; write!(float, Endian.littleEndian)(buffer, motion.y, buffer.length-float.sizeof);buffer.length+=float.sizeof; write!(float, Endian.littleEndian)(buffer, motion.z, buffer.length-float.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				entityId=varlong.fromBuffer(buffer);
				runtimeId=varlong.fromBuffer(buffer);
				item.decode(buffer);
				if(buffer.length>=float.sizeof){ position.x=read!(float, Endian.littleEndian)(buffer); }if(buffer.length>=float.sizeof){ position.y=read!(float, Endian.littleEndian)(buffer); }if(buffer.length>=float.sizeof){ position.z=read!(float, Endian.littleEndian)(buffer); }
				if(buffer.length>=float.sizeof){ motion.x=read!(float, Endian.littleEndian)(buffer); }if(buffer.length>=float.sizeof){ motion.y=read!(float, Endian.littleEndian)(buffer); }if(buffer.length>=float.sizeof){ motion.z=read!(float, Endian.littleEndian)(buffer); }
				return this;
			}

		}

		static struct PlayerInput {

			public enum ubyte packetId = 57;

			public enum bool clientbound = false;
			public enum bool serverbound = true;

			public Tuple!(float, "x", float, "z") motion;
			public ubyte flags;
			public bool unknown;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				buffer.length+=float.sizeof; write!(float, Endian.littleEndian)(buffer, motion.x, buffer.length-float.sizeof);buffer.length+=float.sizeof; write!(float, Endian.littleEndian)(buffer, motion.z, buffer.length-float.sizeof);
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, flags, buffer.length-ubyte.sizeof);
				buffer.length+=bool.sizeof; write!(bool, Endian.bigEndian)(buffer, unknown, buffer.length-bool.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				if(buffer.length>=float.sizeof){ motion.x=read!(float, Endian.littleEndian)(buffer); }if(buffer.length>=float.sizeof){ motion.z=read!(float, Endian.littleEndian)(buffer); }
				if(buffer.length>=ubyte.sizeof){ flags=read!(ubyte, Endian.bigEndian)(buffer); }
				if(buffer.length>=bool.sizeof){ unknown=read!(bool, Endian.bigEndian)(buffer); }
				return this;
			}

		}

		static struct SetHealth {

			public enum ubyte packetId = 42;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public int health;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				buffer~=varint.encode(health);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				health=varint.fromBuffer(buffer);
				return this;
			}

		}

		static struct SetEntityData {

			public enum ubyte packetId = 39;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public long entityId;
			public Types.Metadata metadata;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				buffer~=varlong.encode(entityId);
				metadata.encode(buffer);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				entityId=varlong.fromBuffer(buffer);
				metadata.decode(buffer);
				return this;
			}

		}

		static struct RemoveBlock {

			public enum ubyte packetId = 22;

			public enum bool clientbound = false;
			public enum bool serverbound = true;

			public Types.BlockPosition position;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				position.encode(buffer);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				position.decode(buffer);
				return this;
			}

		}

		static struct Animate {

			public enum ubyte packetId = 44;

			public enum bool clientbound = true;
			public enum bool serverbound = true;

			public int action;
			public long entityId;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				buffer~=varint.encode(action);
				buffer~=varlong.encode(entityId);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				action=varint.fromBuffer(buffer);
				entityId=varlong.fromBuffer(buffer);
				return this;
			}

		}

		static struct ContainerSetSlot {

			public enum ubyte packetId = 50;

			public enum bool clientbound = true;
			public enum bool serverbound = true;

			public ubyte window;
			public int slot;
			public int hotbarSlot;
			public Types.Slot item;
			public ubyte unknown;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, window, buffer.length-ubyte.sizeof);
				buffer~=varint.encode(slot);
				buffer~=varint.encode(hotbarSlot);
				item.encode(buffer);
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, unknown, buffer.length-ubyte.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				if(buffer.length>=ubyte.sizeof){ window=read!(ubyte, Endian.bigEndian)(buffer); }
				slot=varint.fromBuffer(buffer);
				hotbarSlot=varint.fromBuffer(buffer);
				item.decode(buffer);
				if(buffer.length>=ubyte.sizeof){ unknown=read!(ubyte, Endian.bigEndian)(buffer); }
				return this;
			}

		}

		static struct ResourcePacksInfo {

			public enum ubyte packetId = 7;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public bool mustAccept;
			public Types.Pack[] behaviourPacks;
			public Types.Pack[] resourcePacks;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				buffer.length+=bool.sizeof; write!(bool, Endian.bigEndian)(buffer, mustAccept, buffer.length-bool.sizeof);
				buffer~=varuint.encode(behaviourPacks.length.to!uint);foreach(YmVoYXZpb3VyUGFj;behaviourPacks){ YmVoYXZpb3VyUGFj.encode(buffer); }
				buffer~=varuint.encode(resourcePacks.length.to!uint);foreach(cmVzb3VyY2VQYWNr;resourcePacks){ cmVzb3VyY2VQYWNr.encode(buffer); }
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				if(buffer.length>=bool.sizeof){ mustAccept=read!(bool, Endian.bigEndian)(buffer); }
				behaviourPacks.length=varuint.fromBuffer(buffer);foreach(ref YmVoYXZpb3VyUGFj;behaviourPacks){ YmVoYXZpb3VyUGFj.decode(buffer);}
				resourcePacks.length=varuint.fromBuffer(buffer);foreach(ref cmVzb3VyY2VQYWNr;resourcePacks){ cmVzb3VyY2VQYWNr.decode(buffer);}
				return this;
			}

		}

		static struct RemoveEntity {

			public enum ubyte packetId = 15;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public long entityId;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				buffer~=varlong.encode(entityId);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				entityId=varlong.fromBuffer(buffer);
				return this;
			}

		}

		static struct AddHangingEntity {

			public enum ubyte packetId = 17;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public long entityId;
			public long runtimeId;
			public Types.BlockPosition position;
			public int unknown;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				buffer~=varlong.encode(entityId);
				buffer~=varlong.encode(runtimeId);
				position.encode(buffer);
				buffer~=varint.encode(unknown);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				entityId=varlong.fromBuffer(buffer);
				runtimeId=varlong.fromBuffer(buffer);
				position.decode(buffer);
				unknown=varint.fromBuffer(buffer);
				return this;
			}

		}

		static struct ResourcePackClientResponse {

			public enum ubyte packetId = 9;

			public enum bool clientbound = false;
			public enum bool serverbound = true;

			public ubyte status;
			public ushort resourcePackVersion;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, status, buffer.length-ubyte.sizeof);
				buffer.length+=ushort.sizeof; write!(ushort, Endian.bigEndian)(buffer, resourcePackVersion, buffer.length-ushort.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				if(buffer.length>=ubyte.sizeof){ status=read!(ubyte, Endian.bigEndian)(buffer); }
				if(buffer.length>=ushort.sizeof){ resourcePackVersion=read!(ushort, Endian.bigEndian)(buffer); }
				return this;
			}

		}

		static struct ContainerSetData {

			public enum ubyte packetId = 51;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public ubyte window;
			public int property;
			public int value;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, window, buffer.length-ubyte.sizeof);
				buffer~=varint.encode(property);
				buffer~=varint.encode(value);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				if(buffer.length>=ubyte.sizeof){ window=read!(ubyte, Endian.bigEndian)(buffer); }
				property=varint.fromBuffer(buffer);
				value=varint.fromBuffer(buffer);
				return this;
			}

		}

		static struct AddEntity {

			public enum ubyte packetId = 14;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public long entityId;
			public long runtimeId;
			public uint type;
			public Tuple!(float, "x", float, "y", float, "z") position;
			public Tuple!(float, "x", float, "y", float, "z") motion;
			public float pitch;
			public float yaw;
			public Types.Attribute[] attributes;
			public Types.Metadata metadata;
			public long[] links;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				buffer~=varlong.encode(entityId);
				buffer~=varlong.encode(runtimeId);
				buffer~=varuint.encode(type);
				buffer.length+=float.sizeof; write!(float, Endian.littleEndian)(buffer, position.x, buffer.length-float.sizeof);buffer.length+=float.sizeof; write!(float, Endian.littleEndian)(buffer, position.y, buffer.length-float.sizeof);buffer.length+=float.sizeof; write!(float, Endian.littleEndian)(buffer, position.z, buffer.length-float.sizeof);
				buffer.length+=float.sizeof; write!(float, Endian.littleEndian)(buffer, motion.x, buffer.length-float.sizeof);buffer.length+=float.sizeof; write!(float, Endian.littleEndian)(buffer, motion.y, buffer.length-float.sizeof);buffer.length+=float.sizeof; write!(float, Endian.littleEndian)(buffer, motion.z, buffer.length-float.sizeof);
				buffer.length+=float.sizeof; write!(float, Endian.littleEndian)(buffer, pitch, buffer.length-float.sizeof);
				buffer.length+=float.sizeof; write!(float, Endian.littleEndian)(buffer, yaw, buffer.length-float.sizeof);
				buffer~=varuint.encode(attributes.length.to!uint);foreach(YXR0cmlidXRlcw;attributes){ YXR0cmlidXRlcw.encode(buffer); }
				metadata.encode(buffer);
				buffer~=varuint.encode(links.length.to!uint);foreach(bGlua3M;links){ buffer~=varlong.encode(bGlua3M); }
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				entityId=varlong.fromBuffer(buffer);
				runtimeId=varlong.fromBuffer(buffer);
				type=varuint.fromBuffer(buffer);
				if(buffer.length>=float.sizeof){ position.x=read!(float, Endian.littleEndian)(buffer); }if(buffer.length>=float.sizeof){ position.y=read!(float, Endian.littleEndian)(buffer); }if(buffer.length>=float.sizeof){ position.z=read!(float, Endian.littleEndian)(buffer); }
				if(buffer.length>=float.sizeof){ motion.x=read!(float, Endian.littleEndian)(buffer); }if(buffer.length>=float.sizeof){ motion.y=read!(float, Endian.littleEndian)(buffer); }if(buffer.length>=float.sizeof){ motion.z=read!(float, Endian.littleEndian)(buffer); }
				if(buffer.length>=float.sizeof){ pitch=read!(float, Endian.littleEndian)(buffer); }
				if(buffer.length>=float.sizeof){ yaw=read!(float, Endian.littleEndian)(buffer); }
				attributes.length=varuint.fromBuffer(buffer);foreach(ref YXR0cmlidXRlcw;attributes){ YXR0cmlidXRlcw.decode(buffer);}
				metadata.decode(buffer);
				links.length=varuint.fromBuffer(buffer);foreach(ref bGlua3M;links){ bGlua3M=varlong.fromBuffer(buffer);}
				return this;
			}

		}

		static struct FullChunkData {

			public enum ubyte packetId = 58;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public Tuple!(int, "x", int, "z") position;
			public ubyte[] data;
			public ubyte[][] tiles;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				buffer~=varint.encode(position.x);buffer~=varint.encode(position.z);
				buffer~=varuint.encode(data.length.to!uint); buffer~=data;
				buffer~=varuint.encode(tiles.length.to!uint);foreach(dGlsZXM;tiles){ buffer~=varuint.encode(dGlsZXM.length.to!uint); buffer~=dGlsZXM; }
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				position.x=varint.fromBuffer(buffer);position.z=varint.fromBuffer(buffer);
				data.length=varuint.fromBuffer(buffer);if(buffer.length>=data.length){ data=buffer[0..data.length]; buffer=buffer[data.length..$]; }
				tiles.length=varuint.fromBuffer(buffer);foreach(ref dGlsZXM;tiles){ dGlsZXM.length=varuint.fromBuffer(buffer);if(buffer.length>=dGlsZXM.length){ dGlsZXM=buffer[0..dGlsZXM.length]; buffer=buffer[dGlsZXM.length..$]; }}
				return this;
			}

		}

		static struct SetTime {

			public enum ubyte packetId = 11;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public int time;
			public bool doDaylightCycle;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				buffer~=varint.encode(time);
				buffer.length+=bool.sizeof; write!(bool, Endian.bigEndian)(buffer, doDaylightCycle, buffer.length-bool.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				time=varint.fromBuffer(buffer);
				if(buffer.length>=bool.sizeof){ doDaylightCycle=read!(bool, Endian.bigEndian)(buffer); }
				return this;
			}

		}

		static struct MovePlayer {

			public enum ubyte packetId = 20;

			public enum bool clientbound = true;
			public enum bool serverbound = true;

			public long entityId;
			public Tuple!(float, "x", float, "y", float, "z") position;
			public float pitch;
			public float headYaw;
			public float yaw;
			public ubyte mode;
			public bool onGround;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				buffer~=varlong.encode(entityId);
				buffer.length+=float.sizeof; write!(float, Endian.littleEndian)(buffer, position.x, buffer.length-float.sizeof);buffer.length+=float.sizeof; write!(float, Endian.littleEndian)(buffer, position.y, buffer.length-float.sizeof);buffer.length+=float.sizeof; write!(float, Endian.littleEndian)(buffer, position.z, buffer.length-float.sizeof);
				buffer.length+=float.sizeof; write!(float, Endian.littleEndian)(buffer, pitch, buffer.length-float.sizeof);
				buffer.length+=float.sizeof; write!(float, Endian.littleEndian)(buffer, headYaw, buffer.length-float.sizeof);
				buffer.length+=float.sizeof; write!(float, Endian.littleEndian)(buffer, yaw, buffer.length-float.sizeof);
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, mode, buffer.length-ubyte.sizeof);
				buffer.length+=bool.sizeof; write!(bool, Endian.bigEndian)(buffer, onGround, buffer.length-bool.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				entityId=varlong.fromBuffer(buffer);
				if(buffer.length>=float.sizeof){ position.x=read!(float, Endian.littleEndian)(buffer); }if(buffer.length>=float.sizeof){ position.y=read!(float, Endian.littleEndian)(buffer); }if(buffer.length>=float.sizeof){ position.z=read!(float, Endian.littleEndian)(buffer); }
				if(buffer.length>=float.sizeof){ pitch=read!(float, Endian.littleEndian)(buffer); }
				if(buffer.length>=float.sizeof){ headYaw=read!(float, Endian.littleEndian)(buffer); }
				if(buffer.length>=float.sizeof){ yaw=read!(float, Endian.littleEndian)(buffer); }
				if(buffer.length>=ubyte.sizeof){ mode=read!(ubyte, Endian.bigEndian)(buffer); }
				if(buffer.length>=bool.sizeof){ onGround=read!(bool, Endian.bigEndian)(buffer); }
				return this;
			}

		}

		static struct ChangeDimension {

			public enum ubyte packetId = 61;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public int dimension;
			public Tuple!(float, "x", float, "y", float, "z") position;
			public bool unknown;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				buffer~=varint.encode(dimension);
				buffer.length+=float.sizeof; write!(float, Endian.littleEndian)(buffer, position.x, buffer.length-float.sizeof);buffer.length+=float.sizeof; write!(float, Endian.littleEndian)(buffer, position.y, buffer.length-float.sizeof);buffer.length+=float.sizeof; write!(float, Endian.littleEndian)(buffer, position.z, buffer.length-float.sizeof);
				buffer.length+=bool.sizeof; write!(bool, Endian.bigEndian)(buffer, unknown, buffer.length-bool.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				dimension=varint.fromBuffer(buffer);
				if(buffer.length>=float.sizeof){ position.x=read!(float, Endian.littleEndian)(buffer); }if(buffer.length>=float.sizeof){ position.y=read!(float, Endian.littleEndian)(buffer); }if(buffer.length>=float.sizeof){ position.z=read!(float, Endian.littleEndian)(buffer); }
				if(buffer.length>=bool.sizeof){ unknown=read!(bool, Endian.bigEndian)(buffer); }
				return this;
			}

		}

		static struct Login {

			public enum ubyte packetId = 1;

			public enum bool clientbound = false;
			public enum bool serverbound = true;

			public uint protocol;
			public ubyte edition;
			public ubyte[] body_;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				buffer.length+=uint.sizeof; write!(uint, Endian.bigEndian)(buffer, protocol, buffer.length-uint.sizeof);
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, edition, buffer.length-ubyte.sizeof);
				buffer~=varuint.encode(body_.length.to!uint); buffer~=body_;
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				if(buffer.length>=uint.sizeof){ protocol=read!(uint, Endian.bigEndian)(buffer); }
				if(buffer.length>=ubyte.sizeof){ edition=read!(ubyte, Endian.bigEndian)(buffer); }
				body_.length=varuint.fromBuffer(buffer);if(buffer.length>=body_.length){ body_=buffer[0..body_.length]; buffer=buffer[body_.length..$]; }
				return this;
			}

		}

		static struct MobEquipment {

			public enum ubyte packetId = 32;

			public enum bool clientbound = true;
			public enum bool serverbound = true;

			public long entityId;
			public Types.Slot item;
			public ubyte slot;
			public ubyte selectedSlot;
			public ubyte unknown;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				buffer~=varlong.encode(entityId);
				item.encode(buffer);
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, slot, buffer.length-ubyte.sizeof);
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, selectedSlot, buffer.length-ubyte.sizeof);
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, unknown, buffer.length-ubyte.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				entityId=varlong.fromBuffer(buffer);
				item.decode(buffer);
				if(buffer.length>=ubyte.sizeof){ slot=read!(ubyte, Endian.bigEndian)(buffer); }
				if(buffer.length>=ubyte.sizeof){ selectedSlot=read!(ubyte, Endian.bigEndian)(buffer); }
				if(buffer.length>=ubyte.sizeof){ unknown=read!(ubyte, Endian.bigEndian)(buffer); }
				return this;
			}

		}

		static struct AddPlayer {

			public enum ubyte packetId = 13;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public UUID playerUuid;
			public string username;
			public long entityId;
			public long runtimeId;
			public Tuple!(float, "x", float, "y", float, "z") position;
			public Tuple!(float, "x", float, "y", float, "z") motion;
			public float pitch;
			public float headYaw;
			public float yaw;
			public Types.Slot heldItem;
			public Types.Metadata metadata;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				buffer~=playerUuid.data;
				ubyte[] dXNlcm5hbWU=cast(ubyte[])username; buffer~=varuint.encode(dXNlcm5hbWU.length.to!uint); buffer~=dXNlcm5hbWU;
				buffer~=varlong.encode(entityId);
				buffer~=varlong.encode(runtimeId);
				buffer.length+=float.sizeof; write!(float, Endian.littleEndian)(buffer, position.x, buffer.length-float.sizeof);buffer.length+=float.sizeof; write!(float, Endian.littleEndian)(buffer, position.y, buffer.length-float.sizeof);buffer.length+=float.sizeof; write!(float, Endian.littleEndian)(buffer, position.z, buffer.length-float.sizeof);
				buffer.length+=float.sizeof; write!(float, Endian.littleEndian)(buffer, motion.x, buffer.length-float.sizeof);buffer.length+=float.sizeof; write!(float, Endian.littleEndian)(buffer, motion.y, buffer.length-float.sizeof);buffer.length+=float.sizeof; write!(float, Endian.littleEndian)(buffer, motion.z, buffer.length-float.sizeof);
				buffer.length+=float.sizeof; write!(float, Endian.littleEndian)(buffer, pitch, buffer.length-float.sizeof);
				buffer.length+=float.sizeof; write!(float, Endian.littleEndian)(buffer, headYaw, buffer.length-float.sizeof);
				buffer.length+=float.sizeof; write!(float, Endian.littleEndian)(buffer, yaw, buffer.length-float.sizeof);
				heldItem.encode(buffer);
				metadata.encode(buffer);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				if(buffer.length>=16){ ubyte[16] cGxheWVyVXVpZA=buffer[0..16]; buffer=buffer[16..$]; playerUuid=UUID(cGxheWVyVXVpZA); }
				ubyte[] dXNlcm5hbWU; dXNlcm5hbWU.length=varuint.fromBuffer(buffer);if(buffer.length>=dXNlcm5hbWU.length){ dXNlcm5hbWU=buffer[0..dXNlcm5hbWU.length]; buffer=buffer[dXNlcm5hbWU.length..$]; }; username=cast(string)dXNlcm5hbWU;
				entityId=varlong.fromBuffer(buffer);
				runtimeId=varlong.fromBuffer(buffer);
				if(buffer.length>=float.sizeof){ position.x=read!(float, Endian.littleEndian)(buffer); }if(buffer.length>=float.sizeof){ position.y=read!(float, Endian.littleEndian)(buffer); }if(buffer.length>=float.sizeof){ position.z=read!(float, Endian.littleEndian)(buffer); }
				if(buffer.length>=float.sizeof){ motion.x=read!(float, Endian.littleEndian)(buffer); }if(buffer.length>=float.sizeof){ motion.y=read!(float, Endian.littleEndian)(buffer); }if(buffer.length>=float.sizeof){ motion.z=read!(float, Endian.littleEndian)(buffer); }
				if(buffer.length>=float.sizeof){ pitch=read!(float, Endian.littleEndian)(buffer); }
				if(buffer.length>=float.sizeof){ headYaw=read!(float, Endian.littleEndian)(buffer); }
				if(buffer.length>=float.sizeof){ yaw=read!(float, Endian.littleEndian)(buffer); }
				heldItem.decode(buffer);
				metadata.decode(buffer);
				return this;
			}

		}

		static struct InventoryAction {

			public enum ubyte packetId = 47;

			public enum bool clientbound = false;
			public enum bool serverbound = true;

			public int action;
			public Types.Slot item;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				buffer~=varint.encode(action);
				item.encode(buffer);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				action=varint.fromBuffer(buffer);
				item.decode(buffer);
				return this;
			}

		}

		static struct CraftingData {

			public enum ubyte packetId = 53;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public Types.Recipe[] recipes;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				buffer~=varuint.encode(recipes.length.to!uint);foreach(cmVjaXBlcw;recipes){ cmVjaXBlcw.encode(buffer); }
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				recipes.length=varuint.fromBuffer(buffer);foreach(ref cmVjaXBlcw;recipes){ cmVjaXBlcw.decode(buffer);}
				return this;
			}

		}

		static struct MobEffect {

			public enum ubyte packetId = 30;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public long entityId;
			public ubyte event;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				buffer~=varlong.encode(entityId);
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, event, buffer.length-ubyte.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				entityId=varlong.fromBuffer(buffer);
				if(buffer.length>=ubyte.sizeof){ event=read!(ubyte, Endian.bigEndian)(buffer); }
				return this;
			}

			static struct Remove {

				public long entityId;
				public enum ubyte event = 2;

				public ubyte[] encode(bool write_id=true)() {
					ubyte[] buffer;
					static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
					buffer~=varlong.encode(entityId);
					buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, event, buffer.length-ubyte.sizeof);
					return buffer;
				}

				public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
					static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
					entityId=varlong.fromBuffer(buffer);
					ubyte __field_value; if(buffer.length>=ubyte.sizeof){ __field_value=read!(ubyte, Endian.bigEndian)(buffer); }
					return this;
				}

			}

			static struct Add {

				public long entityId;
				public enum ubyte event = 0;
				public int effect;
				public int amplifier;
				public bool particles;
				public int duration;

				public ubyte[] encode(bool write_id=true)() {
					ubyte[] buffer;
					static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
					buffer~=varlong.encode(entityId);
					buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, event, buffer.length-ubyte.sizeof);
					buffer~=varint.encode(effect);
					buffer~=varint.encode(amplifier);
					buffer.length+=bool.sizeof; write!(bool, Endian.bigEndian)(buffer, particles, buffer.length-bool.sizeof);
					buffer~=varint.encode(duration);
					return buffer;
				}

				public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
					static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
					entityId=varlong.fromBuffer(buffer);
					ubyte __field_value; if(buffer.length>=ubyte.sizeof){ __field_value=read!(ubyte, Endian.bigEndian)(buffer); }
					effect=varint.fromBuffer(buffer);
					amplifier=varint.fromBuffer(buffer);
					if(buffer.length>=bool.sizeof){ particles=read!(bool, Endian.bigEndian)(buffer); }
					duration=varint.fromBuffer(buffer);
					return this;
				}

			}

		}

		static struct BlockEvent {

			public enum ubyte packetId = 28;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public Types.BlockPosition position;
			public int[2] data;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				position.encode(buffer);
				foreach(ZGF0YQ;data){ buffer~=varint.encode(ZGF0YQ); }
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				position.decode(buffer);
				foreach(ref ZGF0YQ;data){ ZGF0YQ=varint.fromBuffer(buffer);}
				return this;
			}

		}

		static struct UpdateBlock {

			public enum ubyte packetId = 23;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public Types.BlockPosition position;
			public uint block;
			public uint flagsAndMeta;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				position.encode(buffer);
				buffer~=varuint.encode(block);
				buffer~=varuint.encode(flagsAndMeta);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				position.decode(buffer);
				block=varuint.fromBuffer(buffer);
				flagsAndMeta=varuint.fromBuffer(buffer);
				return this;
			}

		}

		static struct ServerHandshake {

			public enum ubyte packetId = 3;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public string serverPublicKey;
			public ubyte[] token;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				ubyte[] c2VydmVyUHVibGlj=cast(ubyte[])serverPublicKey; buffer~=varuint.encode(c2VydmVyUHVibGlj.length.to!uint); buffer~=c2VydmVyUHVibGlj;
				buffer~=varuint.encode(token.length.to!uint); buffer~=token;
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				ubyte[] c2VydmVyUHVibGlj; c2VydmVyUHVibGlj.length=varuint.fromBuffer(buffer);if(buffer.length>=c2VydmVyUHVibGlj.length){ c2VydmVyUHVibGlj=buffer[0..c2VydmVyUHVibGlj.length]; buffer=buffer[c2VydmVyUHVibGlj.length..$]; }; serverPublicKey=cast(string)c2VydmVyUHVibGlj;
				token.length=varuint.fromBuffer(buffer);if(buffer.length>=token.length){ token=buffer[0..token.length]; buffer=buffer[token.length..$]; }
				return this;
			}

		}

		static struct ContainerSetContent {

			public enum ubyte packetId = 52;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public ubyte window;
			public Types.Slot[] slots;
			public int[] hotbar;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, window, buffer.length-ubyte.sizeof);
				buffer~=varuint.encode(slots.length.to!uint);foreach(c2xvdHM;slots){ c2xvdHM.encode(buffer); }
				buffer~=varuint.encode(hotbar.length.to!uint);foreach(aG90YmFy;hotbar){ buffer~=varint.encode(aG90YmFy); }
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				if(buffer.length>=ubyte.sizeof){ window=read!(ubyte, Endian.bigEndian)(buffer); }
				slots.length=varuint.fromBuffer(buffer);foreach(ref c2xvdHM;slots){ c2xvdHM.decode(buffer);}
				hotbar.length=varuint.fromBuffer(buffer);foreach(ref aG90YmFy;hotbar){ aG90YmFy=varint.fromBuffer(buffer);}
				return this;
			}

		}

		static struct StartGame {

			public enum ubyte packetId = 12;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public long entityId;
			public long runtimeId;
			public Tuple!(float, "x", float, "y", float, "z") position;
			public float yaw;
			public float pitch;
			public int seed;
			public int dimension;
			public int generator;
			public int worldGamemode;
			public int difficulty;
			public Tuple!(int, "x", int, "y", int, "z") spawnPosition;
			public bool loadedInCreative;
			public int time;
			public bool educationMode;
			public float rainLevel;
			public float lightingLevel;
			public bool cheatsEnabled;
			public bool textureRequired;
			public string levelId;
			public string worldName;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				buffer~=varlong.encode(entityId);
				buffer~=varlong.encode(runtimeId);
				buffer.length+=float.sizeof; write!(float, Endian.littleEndian)(buffer, position.x, buffer.length-float.sizeof);buffer.length+=float.sizeof; write!(float, Endian.littleEndian)(buffer, position.y, buffer.length-float.sizeof);buffer.length+=float.sizeof; write!(float, Endian.littleEndian)(buffer, position.z, buffer.length-float.sizeof);
				buffer.length+=float.sizeof; write!(float, Endian.littleEndian)(buffer, yaw, buffer.length-float.sizeof);
				buffer.length+=float.sizeof; write!(float, Endian.littleEndian)(buffer, pitch, buffer.length-float.sizeof);
				buffer~=varint.encode(seed);
				buffer~=varint.encode(dimension);
				buffer~=varint.encode(generator);
				buffer~=varint.encode(worldGamemode);
				buffer~=varint.encode(difficulty);
				buffer~=varint.encode(spawnPosition.x);buffer~=varint.encode(spawnPosition.y);buffer~=varint.encode(spawnPosition.z);
				buffer.length+=bool.sizeof; write!(bool, Endian.bigEndian)(buffer, loadedInCreative, buffer.length-bool.sizeof);
				buffer~=varint.encode(time);
				buffer.length+=bool.sizeof; write!(bool, Endian.bigEndian)(buffer, educationMode, buffer.length-bool.sizeof);
				buffer.length+=float.sizeof; write!(float, Endian.littleEndian)(buffer, rainLevel, buffer.length-float.sizeof);
				buffer.length+=float.sizeof; write!(float, Endian.littleEndian)(buffer, lightingLevel, buffer.length-float.sizeof);
				buffer.length+=bool.sizeof; write!(bool, Endian.bigEndian)(buffer, cheatsEnabled, buffer.length-bool.sizeof);
				buffer.length+=bool.sizeof; write!(bool, Endian.bigEndian)(buffer, textureRequired, buffer.length-bool.sizeof);
				ubyte[] bGV2ZWxJZA=cast(ubyte[])levelId; buffer~=varuint.encode(bGV2ZWxJZA.length.to!uint); buffer~=bGV2ZWxJZA;
				ubyte[] d29ybGROYW1l=cast(ubyte[])worldName; buffer~=varuint.encode(d29ybGROYW1l.length.to!uint); buffer~=d29ybGROYW1l;
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				entityId=varlong.fromBuffer(buffer);
				runtimeId=varlong.fromBuffer(buffer);
				if(buffer.length>=float.sizeof){ position.x=read!(float, Endian.littleEndian)(buffer); }if(buffer.length>=float.sizeof){ position.y=read!(float, Endian.littleEndian)(buffer); }if(buffer.length>=float.sizeof){ position.z=read!(float, Endian.littleEndian)(buffer); }
				if(buffer.length>=float.sizeof){ yaw=read!(float, Endian.littleEndian)(buffer); }
				if(buffer.length>=float.sizeof){ pitch=read!(float, Endian.littleEndian)(buffer); }
				seed=varint.fromBuffer(buffer);
				dimension=varint.fromBuffer(buffer);
				generator=varint.fromBuffer(buffer);
				worldGamemode=varint.fromBuffer(buffer);
				difficulty=varint.fromBuffer(buffer);
				spawnPosition.x=varint.fromBuffer(buffer);spawnPosition.y=varint.fromBuffer(buffer);spawnPosition.z=varint.fromBuffer(buffer);
				if(buffer.length>=bool.sizeof){ loadedInCreative=read!(bool, Endian.bigEndian)(buffer); }
				time=varint.fromBuffer(buffer);
				if(buffer.length>=bool.sizeof){ educationMode=read!(bool, Endian.bigEndian)(buffer); }
				if(buffer.length>=float.sizeof){ rainLevel=read!(float, Endian.littleEndian)(buffer); }
				if(buffer.length>=float.sizeof){ lightingLevel=read!(float, Endian.littleEndian)(buffer); }
				if(buffer.length>=bool.sizeof){ cheatsEnabled=read!(bool, Endian.bigEndian)(buffer); }
				if(buffer.length>=bool.sizeof){ textureRequired=read!(bool, Endian.bigEndian)(buffer); }
				ubyte[] bGV2ZWxJZA; bGV2ZWxJZA.length=varuint.fromBuffer(buffer);if(buffer.length>=bGV2ZWxJZA.length){ bGV2ZWxJZA=buffer[0..bGV2ZWxJZA.length]; buffer=buffer[bGV2ZWxJZA.length..$]; }; levelId=cast(string)bGV2ZWxJZA;
				ubyte[] d29ybGROYW1l; d29ybGROYW1l.length=varuint.fromBuffer(buffer);if(buffer.length>=d29ybGROYW1l.length){ d29ybGROYW1l=buffer[0..d29ybGROYW1l.length]; buffer=buffer[d29ybGROYW1l.length..$]; }; worldName=cast(string)d29ybGROYW1l;
				return this;
			}

		}

		static struct BlockEntityData {

			public enum ubyte packetId = 56;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public Types.BlockPosition position;
			public Types.Metadata metadata;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				position.encode(buffer);
				metadata.encode(buffer);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				position.decode(buffer);
				metadata.decode(buffer);
				return this;
			}

		}

		static struct ContainerOpen {

			public enum ubyte packetId = 48;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public ubyte window;
			public ubyte type;
			public int slotCount;
			public Types.BlockPosition position;
			public long entityId;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, window, buffer.length-ubyte.sizeof);
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, type, buffer.length-ubyte.sizeof);
				buffer~=varint.encode(slotCount);
				position.encode(buffer);
				buffer~=varlong.encode(entityId);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				if(buffer.length>=ubyte.sizeof){ window=read!(ubyte, Endian.bigEndian)(buffer); }
				if(buffer.length>=ubyte.sizeof){ type=read!(ubyte, Endian.bigEndian)(buffer); }
				slotCount=varint.fromBuffer(buffer);
				position.decode(buffer);
				entityId=varlong.fromBuffer(buffer);
				return this;
			}

		}

		static struct SetEntityMotion {

			public enum ubyte packetId = 40;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public long entityId;
			public Tuple!(float, "x", float, "y", float, "z") motion;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				buffer~=varlong.encode(entityId);
				buffer.length+=float.sizeof; write!(float, Endian.littleEndian)(buffer, motion.x, buffer.length-float.sizeof);buffer.length+=float.sizeof; write!(float, Endian.littleEndian)(buffer, motion.y, buffer.length-float.sizeof);buffer.length+=float.sizeof; write!(float, Endian.littleEndian)(buffer, motion.z, buffer.length-float.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				entityId=varlong.fromBuffer(buffer);
				if(buffer.length>=float.sizeof){ motion.x=read!(float, Endian.littleEndian)(buffer); }if(buffer.length>=float.sizeof){ motion.y=read!(float, Endian.littleEndian)(buffer); }if(buffer.length>=float.sizeof){ motion.z=read!(float, Endian.littleEndian)(buffer); }
				return this;
			}

		}

		static struct AdventureSettings {

			public enum ubyte packetId = 55;

			public enum bool clientbound = true;
			public enum bool serverbound = true;

			public uint flags;
			public uint permissions;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				buffer~=varuint.encode(flags);
				buffer~=varuint.encode(permissions);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				flags=varuint.fromBuffer(buffer);
				permissions=varuint.fromBuffer(buffer);
				return this;
			}

		}

		static struct Text {

			public enum ubyte packetId = 10;

			public enum bool clientbound = true;
			public enum bool serverbound = true;

			public ubyte type;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, type, buffer.length-ubyte.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				if(buffer.length>=ubyte.sizeof){ type=read!(ubyte, Endian.bigEndian)(buffer); }
				return this;
			}

			static struct Translation {

				public enum ubyte type = 2;
				public string message;
				public string[] parameters;

				public ubyte[] encode(bool write_id=true)() {
					ubyte[] buffer;
					static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
					buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, type, buffer.length-ubyte.sizeof);
					ubyte[] bWVzc2FnZQ=cast(ubyte[])message; buffer~=varuint.encode(bWVzc2FnZQ.length.to!uint); buffer~=bWVzc2FnZQ;
					buffer~=varuint.encode(parameters.length.to!uint);foreach(cGFyYW1ldGVycw;parameters){ ubyte[] Y0dGeVlXMWxkR1Z5=cast(ubyte[])cGFyYW1ldGVycw; buffer~=varuint.encode(Y0dGeVlXMWxkR1Z5.length.to!uint); buffer~=Y0dGeVlXMWxkR1Z5; }
					return buffer;
				}

				public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
					static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
					ubyte __field_value; if(buffer.length>=ubyte.sizeof){ __field_value=read!(ubyte, Endian.bigEndian)(buffer); }
					ubyte[] bWVzc2FnZQ; bWVzc2FnZQ.length=varuint.fromBuffer(buffer);if(buffer.length>=bWVzc2FnZQ.length){ bWVzc2FnZQ=buffer[0..bWVzc2FnZQ.length]; buffer=buffer[bWVzc2FnZQ.length..$]; }; message=cast(string)bWVzc2FnZQ;
					parameters.length=varuint.fromBuffer(buffer);foreach(ref cGFyYW1ldGVycw;parameters){ ubyte[] Y0dGeVlXMWxkR1Z5; Y0dGeVlXMWxkR1Z5.length=varuint.fromBuffer(buffer);if(buffer.length>=Y0dGeVlXMWxkR1Z5.length){ Y0dGeVlXMWxkR1Z5=buffer[0..Y0dGeVlXMWxkR1Z5.length]; buffer=buffer[Y0dGeVlXMWxkR1Z5.length..$]; }; cGFyYW1ldGVycw=cast(string)Y0dGeVlXMWxkR1Z5;}
					return this;
				}

			}

			static struct Chat {

				public enum ubyte type = 1;
				public string sender;
				public string message;

				public ubyte[] encode(bool write_id=true)() {
					ubyte[] buffer;
					static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
					buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, type, buffer.length-ubyte.sizeof);
					ubyte[] c2VuZGVy=cast(ubyte[])sender; buffer~=varuint.encode(c2VuZGVy.length.to!uint); buffer~=c2VuZGVy;
					ubyte[] bWVzc2FnZQ=cast(ubyte[])message; buffer~=varuint.encode(bWVzc2FnZQ.length.to!uint); buffer~=bWVzc2FnZQ;
					return buffer;
				}

				public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
					static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
					ubyte __field_value; if(buffer.length>=ubyte.sizeof){ __field_value=read!(ubyte, Endian.bigEndian)(buffer); }
					ubyte[] c2VuZGVy; c2VuZGVy.length=varuint.fromBuffer(buffer);if(buffer.length>=c2VuZGVy.length){ c2VuZGVy=buffer[0..c2VuZGVy.length]; buffer=buffer[c2VuZGVy.length..$]; }; sender=cast(string)c2VuZGVy;
					ubyte[] bWVzc2FnZQ; bWVzc2FnZQ.length=varuint.fromBuffer(buffer);if(buffer.length>=bWVzc2FnZQ.length){ bWVzc2FnZQ=buffer[0..bWVzc2FnZQ.length]; buffer=buffer[bWVzc2FnZQ.length..$]; }; message=cast(string)bWVzc2FnZQ;
					return this;
				}

			}

			static struct Whisper {

				public enum ubyte type = 6;
				public string sender;
				public string message;

				public ubyte[] encode(bool write_id=true)() {
					ubyte[] buffer;
					static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
					buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, type, buffer.length-ubyte.sizeof);
					ubyte[] c2VuZGVy=cast(ubyte[])sender; buffer~=varuint.encode(c2VuZGVy.length.to!uint); buffer~=c2VuZGVy;
					ubyte[] bWVzc2FnZQ=cast(ubyte[])message; buffer~=varuint.encode(bWVzc2FnZQ.length.to!uint); buffer~=bWVzc2FnZQ;
					return buffer;
				}

				public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
					static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
					ubyte __field_value; if(buffer.length>=ubyte.sizeof){ __field_value=read!(ubyte, Endian.bigEndian)(buffer); }
					ubyte[] c2VuZGVy; c2VuZGVy.length=varuint.fromBuffer(buffer);if(buffer.length>=c2VuZGVy.length){ c2VuZGVy=buffer[0..c2VuZGVy.length]; buffer=buffer[c2VuZGVy.length..$]; }; sender=cast(string)c2VuZGVy;
					ubyte[] bWVzc2FnZQ; bWVzc2FnZQ.length=varuint.fromBuffer(buffer);if(buffer.length>=bWVzc2FnZQ.length){ bWVzc2FnZQ=buffer[0..bWVzc2FnZQ.length]; buffer=buffer[bWVzc2FnZQ.length..$]; }; message=cast(string)bWVzc2FnZQ;
					return this;
				}

			}

			static struct Popup {

				public enum ubyte type = 3;
				public string title;
				public string subtitle;

				public ubyte[] encode(bool write_id=true)() {
					ubyte[] buffer;
					static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
					buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, type, buffer.length-ubyte.sizeof);
					ubyte[] dGl0bGU=cast(ubyte[])title; buffer~=varuint.encode(dGl0bGU.length.to!uint); buffer~=dGl0bGU;
					ubyte[] c3VidGl0bGU=cast(ubyte[])subtitle; buffer~=varuint.encode(c3VidGl0bGU.length.to!uint); buffer~=c3VidGl0bGU;
					return buffer;
				}

				public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
					static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
					ubyte __field_value; if(buffer.length>=ubyte.sizeof){ __field_value=read!(ubyte, Endian.bigEndian)(buffer); }
					ubyte[] dGl0bGU; dGl0bGU.length=varuint.fromBuffer(buffer);if(buffer.length>=dGl0bGU.length){ dGl0bGU=buffer[0..dGl0bGU.length]; buffer=buffer[dGl0bGU.length..$]; }; title=cast(string)dGl0bGU;
					ubyte[] c3VidGl0bGU; c3VidGl0bGU.length=varuint.fromBuffer(buffer);if(buffer.length>=c3VidGl0bGU.length){ c3VidGl0bGU=buffer[0..c3VidGl0bGU.length]; buffer=buffer[c3VidGl0bGU.length..$]; }; subtitle=cast(string)c3VidGl0bGU;
					return this;
				}

			}

			static struct System {

				public enum ubyte type = 5;
				public string message;

				public ubyte[] encode(bool write_id=true)() {
					ubyte[] buffer;
					static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
					buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, type, buffer.length-ubyte.sizeof);
					ubyte[] bWVzc2FnZQ=cast(ubyte[])message; buffer~=varuint.encode(bWVzc2FnZQ.length.to!uint); buffer~=bWVzc2FnZQ;
					return buffer;
				}

				public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
					static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
					ubyte __field_value; if(buffer.length>=ubyte.sizeof){ __field_value=read!(ubyte, Endian.bigEndian)(buffer); }
					ubyte[] bWVzc2FnZQ; bWVzc2FnZQ.length=varuint.fromBuffer(buffer);if(buffer.length>=bWVzc2FnZQ.length){ bWVzc2FnZQ=buffer[0..bWVzc2FnZQ.length]; buffer=buffer[bWVzc2FnZQ.length..$]; }; message=cast(string)bWVzc2FnZQ;
					return this;
				}

			}

			static struct Raw {

				public enum ubyte type = 0;
				public string message;

				public ubyte[] encode(bool write_id=true)() {
					ubyte[] buffer;
					static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
					buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, type, buffer.length-ubyte.sizeof);
					ubyte[] bWVzc2FnZQ=cast(ubyte[])message; buffer~=varuint.encode(bWVzc2FnZQ.length.to!uint); buffer~=bWVzc2FnZQ;
					return buffer;
				}

				public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
					static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
					ubyte __field_value; if(buffer.length>=ubyte.sizeof){ __field_value=read!(ubyte, Endian.bigEndian)(buffer); }
					ubyte[] bWVzc2FnZQ; bWVzc2FnZQ.length=varuint.fromBuffer(buffer);if(buffer.length>=bWVzc2FnZQ.length){ bWVzc2FnZQ=buffer[0..bWVzc2FnZQ.length]; buffer=buffer[bWVzc2FnZQ.length..$]; }; message=cast(string)bWVzc2FnZQ;
					return this;
				}

			}

			static struct Tip {

				public enum ubyte type = 4;
				public string message;

				public ubyte[] encode(bool write_id=true)() {
					ubyte[] buffer;
					static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
					buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, type, buffer.length-ubyte.sizeof);
					ubyte[] bWVzc2FnZQ=cast(ubyte[])message; buffer~=varuint.encode(bWVzc2FnZQ.length.to!uint); buffer~=bWVzc2FnZQ;
					return buffer;
				}

				public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
					static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
					ubyte __field_value; if(buffer.length>=ubyte.sizeof){ __field_value=read!(ubyte, Endian.bigEndian)(buffer); }
					ubyte[] bWVzc2FnZQ; bWVzc2FnZQ.length=varuint.fromBuffer(buffer);if(buffer.length>=bWVzc2FnZQ.length){ bWVzc2FnZQ=buffer[0..bWVzc2FnZQ.length]; buffer=buffer[bWVzc2FnZQ.length..$]; }; message=cast(string)bWVzc2FnZQ;
					return this;
				}

			}

		}

		static struct Disconnect {

			public enum ubyte packetId = 5;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public bool hideDisconnectionScreen;
			public string message;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				buffer.length+=bool.sizeof; write!(bool, Endian.bigEndian)(buffer, hideDisconnectionScreen, buffer.length-bool.sizeof);
				ubyte[] bWVzc2FnZQ=cast(ubyte[])message; buffer~=varuint.encode(bWVzc2FnZQ.length.to!uint); buffer~=bWVzc2FnZQ;
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				if(buffer.length>=bool.sizeof){ hideDisconnectionScreen=read!(bool, Endian.bigEndian)(buffer); }
				ubyte[] bWVzc2FnZQ; bWVzc2FnZQ.length=varuint.fromBuffer(buffer);if(buffer.length>=bWVzc2FnZQ.length){ bWVzc2FnZQ=buffer[0..bWVzc2FnZQ.length]; buffer=buffer[bWVzc2FnZQ.length..$]; }; message=cast(string)bWVzc2FnZQ;
				return this;
			}

		}

		static struct SetCheats {

			public enum ubyte packetId = 59;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public bool enabled;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				buffer.length+=bool.sizeof; write!(bool, Endian.bigEndian)(buffer, enabled, buffer.length-bool.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				if(buffer.length>=bool.sizeof){ enabled=read!(bool, Endian.bigEndian)(buffer); }
				return this;
			}

		}

		static struct SetPlayerGametype {

			public enum ubyte packetId = 62;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public int gametype;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				buffer~=varint.encode(gametype);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				gametype=varint.fromBuffer(buffer);
				return this;
			}

		}

		static struct SetSpawnPosition {

			public enum ubyte packetId = 43;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public int unknown;
			public Types.BlockPosition position;
			public bool unknownBool;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				buffer~=varint.encode(unknown);
				position.encode(buffer);
				buffer.length+=bool.sizeof; write!(bool, Endian.bigEndian)(buffer, unknownBool, buffer.length-bool.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				unknown=varint.fromBuffer(buffer);
				position.decode(buffer);
				if(buffer.length>=bool.sizeof){ unknownBool=read!(bool, Endian.bigEndian)(buffer); }
				return this;
			}

		}

		static struct MapInfoRequest {

			public enum ubyte packetId = 67;

			public enum bool clientbound = false;
			public enum bool serverbound = true;

			public long mapId;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				buffer~=varlong.encode(mapId);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				mapId=varlong.fromBuffer(buffer);
				return this;
			}

		}

		static struct LevelEvent {

			public enum ubyte packetId = 27;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public int eventId;
			public Tuple!(float, "x", float, "y", float, "z") position;
			public int data;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				buffer~=varint.encode(eventId);
				buffer.length+=float.sizeof; write!(float, Endian.littleEndian)(buffer, position.x, buffer.length-float.sizeof);buffer.length+=float.sizeof; write!(float, Endian.littleEndian)(buffer, position.y, buffer.length-float.sizeof);buffer.length+=float.sizeof; write!(float, Endian.littleEndian)(buffer, position.z, buffer.length-float.sizeof);
				buffer~=varint.encode(data);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				eventId=varint.fromBuffer(buffer);
				if(buffer.length>=float.sizeof){ position.x=read!(float, Endian.littleEndian)(buffer); }if(buffer.length>=float.sizeof){ position.y=read!(float, Endian.littleEndian)(buffer); }if(buffer.length>=float.sizeof){ position.z=read!(float, Endian.littleEndian)(buffer); }
				data=varint.fromBuffer(buffer);
				return this;
			}

		}

		static struct SpawnExperienceOrb {

			public enum ubyte packetId = 65;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public Tuple!(float, "x", float, "y", float, "z") position;
			public int count;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				buffer.length+=float.sizeof; write!(float, Endian.littleEndian)(buffer, position.x, buffer.length-float.sizeof);buffer.length+=float.sizeof; write!(float, Endian.littleEndian)(buffer, position.y, buffer.length-float.sizeof);buffer.length+=float.sizeof; write!(float, Endian.littleEndian)(buffer, position.z, buffer.length-float.sizeof);
				buffer~=varint.encode(count);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				if(buffer.length>=float.sizeof){ position.x=read!(float, Endian.littleEndian)(buffer); }if(buffer.length>=float.sizeof){ position.y=read!(float, Endian.littleEndian)(buffer); }if(buffer.length>=float.sizeof){ position.z=read!(float, Endian.littleEndian)(buffer); }
				count=varint.fromBuffer(buffer);
				return this;
			}

		}

		static struct CommandStep {

			public enum ubyte packetId = 78;

			public enum bool clientbound = false;
			public enum bool serverbound = true;

			public string command;
			public string overload;
			public uint unknown1;
			public uint unknown2;
			public bool isOutput;
			public ulong unknown3;
			public string input;
			public string output;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				ubyte[] Y29tbWFuZA=cast(ubyte[])command; buffer~=varuint.encode(Y29tbWFuZA.length.to!uint); buffer~=Y29tbWFuZA;
				ubyte[] b3ZlcmxvYWQ=cast(ubyte[])overload; buffer~=varuint.encode(b3ZlcmxvYWQ.length.to!uint); buffer~=b3ZlcmxvYWQ;
				buffer~=varuint.encode(unknown1);
				buffer~=varuint.encode(unknown2);
				buffer.length+=bool.sizeof; write!(bool, Endian.bigEndian)(buffer, isOutput, buffer.length-bool.sizeof);
				buffer~=varulong.encode(unknown3);
				ubyte[] aW5wdXQ=cast(ubyte[])input; buffer~=varuint.encode(aW5wdXQ.length.to!uint); buffer~=aW5wdXQ;
				ubyte[] b3V0cHV0=cast(ubyte[])output; buffer~=varuint.encode(b3V0cHV0.length.to!uint); buffer~=b3V0cHV0;
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				ubyte[] Y29tbWFuZA; Y29tbWFuZA.length=varuint.fromBuffer(buffer);if(buffer.length>=Y29tbWFuZA.length){ Y29tbWFuZA=buffer[0..Y29tbWFuZA.length]; buffer=buffer[Y29tbWFuZA.length..$]; }; command=cast(string)Y29tbWFuZA;
				ubyte[] b3ZlcmxvYWQ; b3ZlcmxvYWQ.length=varuint.fromBuffer(buffer);if(buffer.length>=b3ZlcmxvYWQ.length){ b3ZlcmxvYWQ=buffer[0..b3ZlcmxvYWQ.length]; buffer=buffer[b3ZlcmxvYWQ.length..$]; }; overload=cast(string)b3ZlcmxvYWQ;
				unknown1=varuint.fromBuffer(buffer);
				unknown2=varuint.fromBuffer(buffer);
				if(buffer.length>=bool.sizeof){ isOutput=read!(bool, Endian.bigEndian)(buffer); }
				unknown3=varulong.fromBuffer(buffer);
				ubyte[] aW5wdXQ; aW5wdXQ.length=varuint.fromBuffer(buffer);if(buffer.length>=aW5wdXQ.length){ aW5wdXQ=buffer[0..aW5wdXQ.length]; buffer=buffer[aW5wdXQ.length..$]; }; input=cast(string)aW5wdXQ;
				ubyte[] b3V0cHV0; b3V0cHV0.length=varuint.fromBuffer(buffer);if(buffer.length>=b3V0cHV0.length){ b3V0cHV0=buffer[0..b3V0cHV0.length]; buffer=buffer[b3V0cHV0.length..$]; }; output=cast(string)b3V0cHV0;
				return this;
			}

		}

		static struct MoveEntity {

			public enum ubyte packetId = 19;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public long entityId;
			public Tuple!(float, "x", float, "y", float, "z") position;
			public byte pitch;
			public ubyte headYaw;
			public ubyte yaw;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				buffer~=varlong.encode(entityId);
				buffer.length+=float.sizeof; write!(float, Endian.littleEndian)(buffer, position.x, buffer.length-float.sizeof);buffer.length+=float.sizeof; write!(float, Endian.littleEndian)(buffer, position.y, buffer.length-float.sizeof);buffer.length+=float.sizeof; write!(float, Endian.littleEndian)(buffer, position.z, buffer.length-float.sizeof);
				buffer.length+=byte.sizeof; write!(byte, Endian.bigEndian)(buffer, pitch, buffer.length-byte.sizeof);
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, headYaw, buffer.length-ubyte.sizeof);
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, yaw, buffer.length-ubyte.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				entityId=varlong.fromBuffer(buffer);
				if(buffer.length>=float.sizeof){ position.x=read!(float, Endian.littleEndian)(buffer); }if(buffer.length>=float.sizeof){ position.y=read!(float, Endian.littleEndian)(buffer); }if(buffer.length>=float.sizeof){ position.z=read!(float, Endian.littleEndian)(buffer); }
				if(buffer.length>=byte.sizeof){ pitch=read!(byte, Endian.bigEndian)(buffer); }
				if(buffer.length>=ubyte.sizeof){ headYaw=read!(ubyte, Endian.bigEndian)(buffer); }
				if(buffer.length>=ubyte.sizeof){ yaw=read!(ubyte, Endian.bigEndian)(buffer); }
				return this;
			}

		}

		static struct EntityEvent {

			public enum ubyte packetId = 29;

			public enum bool clientbound = true;
			public enum bool serverbound = true;

			public long entityId;
			public ubyte eventId;
			public int unknown;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				buffer~=varlong.encode(entityId);
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, eventId, buffer.length-ubyte.sizeof);
				buffer~=varint.encode(unknown);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				entityId=varlong.fromBuffer(buffer);
				if(buffer.length>=ubyte.sizeof){ eventId=read!(ubyte, Endian.bigEndian)(buffer); }
				unknown=varint.fromBuffer(buffer);
				return this;
			}

		}

		static struct Respawn {

			public enum ubyte packetId = 45;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public Tuple!(float, "x", float, "y", float, "z") position;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				buffer.length+=float.sizeof; write!(float, Endian.littleEndian)(buffer, position.x, buffer.length-float.sizeof);buffer.length+=float.sizeof; write!(float, Endian.littleEndian)(buffer, position.y, buffer.length-float.sizeof);buffer.length+=float.sizeof; write!(float, Endian.littleEndian)(buffer, position.z, buffer.length-float.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				if(buffer.length>=float.sizeof){ position.x=read!(float, Endian.littleEndian)(buffer); }if(buffer.length>=float.sizeof){ position.y=read!(float, Endian.littleEndian)(buffer); }if(buffer.length>=float.sizeof){ position.z=read!(float, Endian.littleEndian)(buffer); }
				return this;
			}

		}

		static struct LevelSoundEvent {

			public enum ubyte packetId = 26;

			public enum bool clientbound = true;
			public enum bool serverbound = true;

			public ubyte sound;
			public Tuple!(float, "x", float, "y", float, "z") position;
			public uint volume;
			public int pitch;
			public bool unknown;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, sound, buffer.length-ubyte.sizeof);
				buffer.length+=float.sizeof; write!(float, Endian.littleEndian)(buffer, position.x, buffer.length-float.sizeof);buffer.length+=float.sizeof; write!(float, Endian.littleEndian)(buffer, position.y, buffer.length-float.sizeof);buffer.length+=float.sizeof; write!(float, Endian.littleEndian)(buffer, position.z, buffer.length-float.sizeof);
				buffer~=varuint.encode(volume);
				buffer~=varint.encode(pitch);
				buffer.length+=bool.sizeof; write!(bool, Endian.bigEndian)(buffer, unknown, buffer.length-bool.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				if(buffer.length>=ubyte.sizeof){ sound=read!(ubyte, Endian.bigEndian)(buffer); }
				if(buffer.length>=float.sizeof){ position.x=read!(float, Endian.littleEndian)(buffer); }if(buffer.length>=float.sizeof){ position.y=read!(float, Endian.littleEndian)(buffer); }if(buffer.length>=float.sizeof){ position.z=read!(float, Endian.littleEndian)(buffer); }
				volume=varuint.fromBuffer(buffer);
				pitch=varint.fromBuffer(buffer);
				if(buffer.length>=bool.sizeof){ unknown=read!(bool, Endian.bigEndian)(buffer); }
				return this;
			}

		}

		static struct ShowCredits {

			public enum ubyte packetId = 76;

			public enum bool clientbound = true;
			public enum bool serverbound = false;


			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				return this;
			}

		}

		static struct PlayerFall {

			public enum ubyte packetId = 37;

			public enum bool clientbound = false;
			public enum bool serverbound = true;

			public float distance;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				buffer.length+=float.sizeof; write!(float, Endian.littleEndian)(buffer, distance, buffer.length-float.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				if(buffer.length>=float.sizeof){ distance=read!(float, Endian.littleEndian)(buffer); }
				return this;
			}

		}

		static struct ItemFrameDropItem {

			public enum ubyte packetId = 70;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public Types.BlockPosition position;
			public Types.Slot item;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				position.encode(buffer);
				item.encode(buffer);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				position.decode(buffer);
				item.decode(buffer);
				return this;
			}

		}

		static struct ContainerClose {

			public enum ubyte packetId = 49;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public ubyte window;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, window, buffer.length-ubyte.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				if(buffer.length>=ubyte.sizeof){ window=read!(ubyte, Endian.bigEndian)(buffer); }
				return this;
			}

		}

		static struct SetEntityLink {

			public enum ubyte packetId = 41;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public long from;
			public long to;
			public ubyte type;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				buffer~=varlong.encode(from);
				buffer~=varlong.encode(to);
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, type, buffer.length-ubyte.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				from=varlong.fromBuffer(buffer);
				to=varlong.fromBuffer(buffer);
				if(buffer.length>=ubyte.sizeof){ type=read!(ubyte, Endian.bigEndian)(buffer); }
				return this;
			}

		}

	}

}