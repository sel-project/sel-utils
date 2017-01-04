module sul.protocol.minecraft316;

import std.bitmanip : read, write;
import std.conv : to;
import std.uuid : UUID;
import std.system : Endian;
import std.typecons : Tuple, tuple;

import sul.types.var;

static struct Types {

	static struct Property {

		public string name;
		public string value;
		public bool signed;
		public string signature;

		public void encode(ref ubyte[] buffer) {
			ubyte[] bmFtZQ=cast(ubyte[])name; buffer~=varuint.encode(bmFtZQ.length.to!uint); buffer~=bmFtZQ;
			ubyte[] dmFsdWU=cast(ubyte[])value; buffer~=varuint.encode(dmFsdWU.length.to!uint); buffer~=dmFsdWU;
			buffer.length+=bool.sizeof; write!(bool, Endian.bigEndian)(buffer, signed, buffer.length-bool.sizeof);
			if(signed==true){ ubyte[] c2lnbmF0dXJl=cast(ubyte[])signature; buffer~=varuint.encode(c2lnbmF0dXJl.length.to!uint); buffer~=c2lnbmF0dXJl; }
		}

		public void decode(ref ubyte[] buffer) {
			ubyte[] bmFtZQ; bmFtZQ.length=varuint.fromBuffer(buffer);if(buffer.length>=bmFtZQ.length){ bmFtZQ=buffer[0..bmFtZQ.length]; buffer=buffer[bmFtZQ.length..$]; }; name=cast(string)bmFtZQ;
			ubyte[] dmFsdWU; dmFsdWU.length=varuint.fromBuffer(buffer);if(buffer.length>=dmFsdWU.length){ dmFsdWU=buffer[0..dmFsdWU.length]; buffer=buffer[dmFsdWU.length..$]; }; value=cast(string)dmFsdWU;
			if(buffer.length>=bool.sizeof){ signed=read!(bool, Endian.bigEndian)(buffer); }
			if(signed==true){ ubyte[] c2lnbmF0dXJl; c2lnbmF0dXJl.length=varuint.fromBuffer(buffer);if(buffer.length>=c2lnbmF0dXJl.length){ c2lnbmF0dXJl=buffer[0..c2lnbmF0dXJl.length]; buffer=buffer[c2lnbmF0dXJl.length..$]; }; signature=cast(string)c2lnbmF0dXJl; }
		}

	}

	static struct ListUpdateLatency {

		public UUID uuid;
		public uint latency;

		public void encode(ref ubyte[] buffer) {
			buffer~=uuid.data;
			buffer~=varuint.encode(latency);
		}

		public void decode(ref ubyte[] buffer) {
			if(buffer.length>=16){ ubyte[16] dXVpZA=buffer[0..16]; buffer=buffer[16..$]; uuid=UUID(dXVpZA); }
			latency=varuint.fromBuffer(buffer);
		}

	}

	static struct Icon {

		public ubyte directionAndType;
		public Tuple!(ubyte, "x", ubyte, "z") position;

		public void encode(ref ubyte[] buffer) {
			buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, directionAndType, buffer.length-ubyte.sizeof);
			buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, position.x, buffer.length-ubyte.sizeof);buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, position.z, buffer.length-ubyte.sizeof);
		}

		public void decode(ref ubyte[] buffer) {
			if(buffer.length>=ubyte.sizeof){ directionAndType=read!(ubyte, Endian.bigEndian)(buffer); }
			if(buffer.length>=ubyte.sizeof){ position.x=read!(ubyte, Endian.bigEndian)(buffer); }if(buffer.length>=ubyte.sizeof){ position.z=read!(ubyte, Endian.bigEndian)(buffer); }
		}

	}

	static struct ListUpdateDisplayName {

		public UUID uuid;
		public bool hasDisplayName;
		public string displayName;

		public void encode(ref ubyte[] buffer) {
			buffer~=uuid.data;
			buffer.length+=bool.sizeof; write!(bool, Endian.bigEndian)(buffer, hasDisplayName, buffer.length-bool.sizeof);
			if(hasDisplayName==true){ ubyte[] ZGlzcGxheU5hbWU=cast(ubyte[])displayName; buffer~=varuint.encode(ZGlzcGxheU5hbWU.length.to!uint); buffer~=ZGlzcGxheU5hbWU; }
		}

		public void decode(ref ubyte[] buffer) {
			if(buffer.length>=16){ ubyte[16] dXVpZA=buffer[0..16]; buffer=buffer[16..$]; uuid=UUID(dXVpZA); }
			if(buffer.length>=bool.sizeof){ hasDisplayName=read!(bool, Endian.bigEndian)(buffer); }
			if(hasDisplayName==true){ ubyte[] ZGlzcGxheU5hbWU; ZGlzcGxheU5hbWU.length=varuint.fromBuffer(buffer);if(buffer.length>=ZGlzcGxheU5hbWU.length){ ZGlzcGxheU5hbWU=buffer[0..ZGlzcGxheU5hbWU.length]; buffer=buffer[ZGlzcGxheU5hbWU.length..$]; }; displayName=cast(string)ZGlzcGxheU5hbWU; }
		}

	}

	static struct Slot {

		public short id;
		public ubyte count;
		public ushort damage;
		public ubyte[] nbt;

		public void encode(ref ubyte[] buffer) {
			buffer.length+=short.sizeof; write!(short, Endian.bigEndian)(buffer, id, buffer.length-short.sizeof);
			if(id>0){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, count, buffer.length-ubyte.sizeof); }
			if(id>0){ buffer.length+=ushort.sizeof; write!(ushort, Endian.bigEndian)(buffer, damage, buffer.length-ushort.sizeof); }
			if(id>0){ buffer~=nbt; }
		}

		public void decode(ref ubyte[] buffer) {
			if(buffer.length>=short.sizeof){ id=read!(short, Endian.bigEndian)(buffer); }
			if(id>0){ if(buffer.length>=ubyte.sizeof){ count=read!(ubyte, Endian.bigEndian)(buffer); } }
			if(id>0){ if(buffer.length>=ushort.sizeof){ damage=read!(ushort, Endian.bigEndian)(buffer); } }
			if(id>0){ nbt=buffer.dup; buffer.length=0; }
		}

	}

	static struct Statistic {

		public string name;
		public uint value;

		public void encode(ref ubyte[] buffer) {
			ubyte[] bmFtZQ=cast(ubyte[])name; buffer~=varuint.encode(bmFtZQ.length.to!uint); buffer~=bmFtZQ;
			buffer~=varuint.encode(value);
		}

		public void decode(ref ubyte[] buffer) {
			ubyte[] bmFtZQ; bmFtZQ.length=varuint.fromBuffer(buffer);if(buffer.length>=bmFtZQ.length){ bmFtZQ=buffer[0..bmFtZQ.length]; buffer=buffer[bmFtZQ.length..$]; }; name=cast(string)bmFtZQ;
			value=varuint.fromBuffer(buffer);
		}

	}

	static struct BlockChange {

		public ubyte xz;
		public ubyte y;
		public uint block;

		public void encode(ref ubyte[] buffer) {
			buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, xz, buffer.length-ubyte.sizeof);
			buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, y, buffer.length-ubyte.sizeof);
			buffer~=varuint.encode(block);
		}

		public void decode(ref ubyte[] buffer) {
			if(buffer.length>=ubyte.sizeof){ xz=read!(ubyte, Endian.bigEndian)(buffer); }
			if(buffer.length>=ubyte.sizeof){ y=read!(ubyte, Endian.bigEndian)(buffer); }
			block=varuint.fromBuffer(buffer);
		}

	}

	static struct ListUpdateGamemode {

		public UUID uuid;
		public uint gamemode;

		public void encode(ref ubyte[] buffer) {
			buffer~=uuid.data;
			buffer~=varuint.encode(gamemode);
		}

		public void decode(ref ubyte[] buffer) {
			if(buffer.length>=16){ ubyte[16] dXVpZA=buffer[0..16]; buffer=buffer[16..$]; uuid=UUID(dXVpZA); }
			gamemode=varuint.fromBuffer(buffer);
		}

	}

	static struct ListAddPlayer {

		public UUID uuid;
		public string name;
		public Types.Property[] properties;
		public uint gamemode;
		public uint latency;
		public bool hasDisplayName;
		public string displayName;

		public void encode(ref ubyte[] buffer) {
			buffer~=uuid.data;
			ubyte[] bmFtZQ=cast(ubyte[])name; buffer~=varuint.encode(bmFtZQ.length.to!uint); buffer~=bmFtZQ;
			buffer~=varuint.encode(properties.length.to!uint);foreach(cHJvcGVydGllcw;properties){ cHJvcGVydGllcw.encode(buffer); }
			buffer~=varuint.encode(gamemode);
			buffer~=varuint.encode(latency);
			buffer.length+=bool.sizeof; write!(bool, Endian.bigEndian)(buffer, hasDisplayName, buffer.length-bool.sizeof);
			if(hasDisplayName==true){ ubyte[] ZGlzcGxheU5hbWU=cast(ubyte[])displayName; buffer~=varuint.encode(ZGlzcGxheU5hbWU.length.to!uint); buffer~=ZGlzcGxheU5hbWU; }
		}

		public void decode(ref ubyte[] buffer) {
			if(buffer.length>=16){ ubyte[16] dXVpZA=buffer[0..16]; buffer=buffer[16..$]; uuid=UUID(dXVpZA); }
			ubyte[] bmFtZQ; bmFtZQ.length=varuint.fromBuffer(buffer);if(buffer.length>=bmFtZQ.length){ bmFtZQ=buffer[0..bmFtZQ.length]; buffer=buffer[bmFtZQ.length..$]; }; name=cast(string)bmFtZQ;
			properties.length=varuint.fromBuffer(buffer);foreach(ref cHJvcGVydGllcw;properties){ cHJvcGVydGllcw.decode(buffer);}
			gamemode=varuint.fromBuffer(buffer);
			latency=varuint.fromBuffer(buffer);
			if(buffer.length>=bool.sizeof){ hasDisplayName=read!(bool, Endian.bigEndian)(buffer); }
			if(hasDisplayName==true){ ubyte[] ZGlzcGxheU5hbWU; ZGlzcGxheU5hbWU.length=varuint.fromBuffer(buffer);if(buffer.length>=ZGlzcGxheU5hbWU.length){ ZGlzcGxheU5hbWU=buffer[0..ZGlzcGxheU5hbWU.length]; buffer=buffer[ZGlzcGxheU5hbWU.length..$]; }; displayName=cast(string)ZGlzcGxheU5hbWU; }
		}

	}

}

static struct Packets {

	static struct Play {

		static struct SetCooldown {

			public enum uint packetId = 23;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public uint item;
			public uint cooldownTicks;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer~=varuint.encode(item);
				buffer~=varuint.encode(cooldownTicks);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				item=varuint.fromBuffer(buffer);
				cooldownTicks=varuint.fromBuffer(buffer);
				return this;
			}

		}

		static struct PlayerPositionAndLookClientbound {

			public enum uint packetId = 46;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public Tuple!(double, "x", double, "y", double, "z") position;
			public float yaw;
			public float pitch;
			public ubyte flags;
			public uint teleportId;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer.length+=double.sizeof; write!(double, Endian.bigEndian)(buffer, position.x, buffer.length-double.sizeof);buffer.length+=double.sizeof; write!(double, Endian.bigEndian)(buffer, position.y, buffer.length-double.sizeof);buffer.length+=double.sizeof; write!(double, Endian.bigEndian)(buffer, position.z, buffer.length-double.sizeof);
				buffer.length+=float.sizeof; write!(float, Endian.bigEndian)(buffer, yaw, buffer.length-float.sizeof);
				buffer.length+=float.sizeof; write!(float, Endian.bigEndian)(buffer, pitch, buffer.length-float.sizeof);
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, flags, buffer.length-ubyte.sizeof);
				buffer~=varuint.encode(teleportId);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				if(buffer.length>=double.sizeof){ position.x=read!(double, Endian.bigEndian)(buffer); }if(buffer.length>=double.sizeof){ position.y=read!(double, Endian.bigEndian)(buffer); }if(buffer.length>=double.sizeof){ position.z=read!(double, Endian.bigEndian)(buffer); }
				if(buffer.length>=float.sizeof){ yaw=read!(float, Endian.bigEndian)(buffer); }
				if(buffer.length>=float.sizeof){ pitch=read!(float, Endian.bigEndian)(buffer); }
				if(buffer.length>=ubyte.sizeof){ flags=read!(ubyte, Endian.bigEndian)(buffer); }
				teleportId=varuint.fromBuffer(buffer);
				return this;
			}

		}

		static struct DestroyEntities {

			public enum uint packetId = 48;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public uint[] entityIds;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer~=varuint.encode(entityIds.length.to!uint);foreach(ZW50aXR5SWRz;entityIds){ buffer~=varuint.encode(ZW50aXR5SWRz); }
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				entityIds.length=varuint.fromBuffer(buffer);foreach(ref ZW50aXR5SWRz;entityIds){ ZW50aXR5SWRz=varuint.fromBuffer(buffer);}
				return this;
			}

		}

		static struct SetPassengers {

			public enum uint packetId = 64;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public uint entityId;
			public uint[] passengers;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer~=varuint.encode(entityId);
				buffer~=varuint.encode(passengers.length.to!uint);foreach(cGFzc2VuZ2Vycw;passengers){ buffer~=varuint.encode(cGFzc2VuZ2Vycw); }
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				entityId=varuint.fromBuffer(buffer);
				passengers.length=varuint.fromBuffer(buffer);foreach(ref cGFzc2VuZ2Vycw;passengers){ cGFzc2VuZ2Vycw=varuint.fromBuffer(buffer);}
				return this;
			}

		}

		static struct TeleportConfirm {

			public enum uint packetId = 0;

			public enum bool clientbound = false;
			public enum bool serverbound = true;

			public uint teleportId;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer~=varuint.encode(teleportId);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				teleportId=varuint.fromBuffer(buffer);
				return this;
			}

		}

		static struct Camera {

			public enum uint packetId = 54;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public uint entityId;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer~=varuint.encode(entityId);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				entityId=varuint.fromBuffer(buffer);
				return this;
			}

		}

		static struct ChatMessageServerbound {

			public enum uint packetId = 2;

			public enum bool clientbound = false;
			public enum bool serverbound = true;

			public string text;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				ubyte[] dGV4dA=cast(ubyte[])text; buffer~=varuint.encode(dGV4dA.length.to!uint); buffer~=dGV4dA;
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				ubyte[] dGV4dA; dGV4dA.length=varuint.fromBuffer(buffer);if(buffer.length>=dGV4dA.length){ dGV4dA=buffer[0..dGV4dA.length]; buffer=buffer[dGV4dA.length..$]; }; text=cast(string)dGV4dA;
				return this;
			}

		}

		static struct EntityEquipment {

			public enum uint packetId = 60;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public uint entityId;
			public uint slot;
			public Types.Slot item;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer~=varuint.encode(entityId);
				buffer~=varuint.encode(slot);
				item.encode(buffer);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				entityId=varuint.fromBuffer(buffer);
				slot=varuint.fromBuffer(buffer);
				item.decode(buffer);
				return this;
			}

		}

		static struct EntityLook {

			public enum uint packetId = 39;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public uint entityId;
			public ubyte yaw;
			public ubyte pitch;
			public bool onGround;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer~=varuint.encode(entityId);
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, yaw, buffer.length-ubyte.sizeof);
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, pitch, buffer.length-ubyte.sizeof);
				buffer.length+=bool.sizeof; write!(bool, Endian.bigEndian)(buffer, onGround, buffer.length-bool.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				entityId=varuint.fromBuffer(buffer);
				if(buffer.length>=ubyte.sizeof){ yaw=read!(ubyte, Endian.bigEndian)(buffer); }
				if(buffer.length>=ubyte.sizeof){ pitch=read!(ubyte, Endian.bigEndian)(buffer); }
				if(buffer.length>=bool.sizeof){ onGround=read!(bool, Endian.bigEndian)(buffer); }
				return this;
			}

		}

		static struct ChunkData {

			public enum uint packetId = 32;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public Tuple!(int, "x", int, "z") position;
			public bool full;
			public uint sections;
			public ubyte[] data;
			public ubyte[][] tiles;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer.length+=int.sizeof; write!(int, Endian.bigEndian)(buffer, position.x, buffer.length-int.sizeof);buffer.length+=int.sizeof; write!(int, Endian.bigEndian)(buffer, position.z, buffer.length-int.sizeof);
				buffer.length+=bool.sizeof; write!(bool, Endian.bigEndian)(buffer, full, buffer.length-bool.sizeof);
				buffer~=varuint.encode(sections);
				buffer~=varuint.encode(data.length.to!uint); buffer~=data;
				buffer~=varuint.encode(tiles.length.to!uint);foreach(dGlsZXM;tiles){ buffer~=dGlsZXM; }
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				if(buffer.length>=int.sizeof){ position.x=read!(int, Endian.bigEndian)(buffer); }if(buffer.length>=int.sizeof){ position.z=read!(int, Endian.bigEndian)(buffer); }
				if(buffer.length>=bool.sizeof){ full=read!(bool, Endian.bigEndian)(buffer); }
				sections=varuint.fromBuffer(buffer);
				data.length=varuint.fromBuffer(buffer);if(buffer.length>=data.length){ data=buffer[0..data.length]; buffer=buffer[data.length..$]; }
				tiles.length=varuint.fromBuffer(buffer);foreach(ref dGlsZXM;tiles){ dGlsZXM=buffer.dup; buffer.length=0;}
				return this;
			}

		}

		static struct EntityTeleport {

			public enum uint packetId = 73;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public uint entityId;
			public Tuple!(double, "x", double, "y", double, "z") position;
			public ubyte yaw;
			public ubyte pitch;
			public bool onGround;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer~=varuint.encode(entityId);
				buffer.length+=double.sizeof; write!(double, Endian.bigEndian)(buffer, position.x, buffer.length-double.sizeof);buffer.length+=double.sizeof; write!(double, Endian.bigEndian)(buffer, position.y, buffer.length-double.sizeof);buffer.length+=double.sizeof; write!(double, Endian.bigEndian)(buffer, position.z, buffer.length-double.sizeof);
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, yaw, buffer.length-ubyte.sizeof);
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, pitch, buffer.length-ubyte.sizeof);
				buffer.length+=bool.sizeof; write!(bool, Endian.bigEndian)(buffer, onGround, buffer.length-bool.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				entityId=varuint.fromBuffer(buffer);
				if(buffer.length>=double.sizeof){ position.x=read!(double, Endian.bigEndian)(buffer); }if(buffer.length>=double.sizeof){ position.y=read!(double, Endian.bigEndian)(buffer); }if(buffer.length>=double.sizeof){ position.z=read!(double, Endian.bigEndian)(buffer); }
				if(buffer.length>=ubyte.sizeof){ yaw=read!(ubyte, Endian.bigEndian)(buffer); }
				if(buffer.length>=ubyte.sizeof){ pitch=read!(ubyte, Endian.bigEndian)(buffer); }
				if(buffer.length>=bool.sizeof){ onGround=read!(bool, Endian.bigEndian)(buffer); }
				return this;
			}

		}

		static struct OpenSignEditor {

			public enum uint packetId = 42;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public ulong position;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer.length+=ulong.sizeof; write!(ulong, Endian.bigEndian)(buffer, position, buffer.length-ulong.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				if(buffer.length>=ulong.sizeof){ position=read!(ulong, Endian.bigEndian)(buffer); }
				return this;
			}

		}

		static struct ClientStatus {

			public enum uint packetId = 3;

			public enum bool clientbound = false;
			public enum bool serverbound = true;

			public uint action;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer~=varuint.encode(action);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				action=varuint.fromBuffer(buffer);
				return this;
			}

		}

		static struct UpdateScore {

			public enum uint packetId = 66;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public string scoreName;
			public ubyte action;
			public string objectiveName;
			public uint value;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				ubyte[] c2NvcmVOYW1l=cast(ubyte[])scoreName; buffer~=varuint.encode(c2NvcmVOYW1l.length.to!uint); buffer~=c2NvcmVOYW1l;
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, action, buffer.length-ubyte.sizeof);
				ubyte[] b2JqZWN0aXZlTmFt=cast(ubyte[])objectiveName; buffer~=varuint.encode(b2JqZWN0aXZlTmFt.length.to!uint); buffer~=b2JqZWN0aXZlTmFt;
				buffer~=varuint.encode(value);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				ubyte[] c2NvcmVOYW1l; c2NvcmVOYW1l.length=varuint.fromBuffer(buffer);if(buffer.length>=c2NvcmVOYW1l.length){ c2NvcmVOYW1l=buffer[0..c2NvcmVOYW1l.length]; buffer=buffer[c2NvcmVOYW1l.length..$]; }; scoreName=cast(string)c2NvcmVOYW1l;
				if(buffer.length>=ubyte.sizeof){ action=read!(ubyte, Endian.bigEndian)(buffer); }
				ubyte[] b2JqZWN0aXZlTmFt; b2JqZWN0aXZlTmFt.length=varuint.fromBuffer(buffer);if(buffer.length>=b2JqZWN0aXZlTmFt.length){ b2JqZWN0aXZlTmFt=buffer[0..b2JqZWN0aXZlTmFt.length]; buffer=buffer[b2JqZWN0aXZlTmFt.length..$]; }; objectiveName=cast(string)b2JqZWN0aXZlTmFt;
				value=varuint.fromBuffer(buffer);
				return this;
			}

		}

		static struct KeepAliveClientbound {

			public enum uint packetId = 31;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public uint id;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer~=varuint.encode(id);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				id=varuint.fromBuffer(buffer);
				return this;
			}

		}

		static struct EntityEffect {

			public enum uint packetId = 75;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public uint entityId;
			public ubyte effect;
			public ubyte amplifier;
			public uint duration;
			public ubyte flags;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer~=varuint.encode(entityId);
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, effect, buffer.length-ubyte.sizeof);
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, amplifier, buffer.length-ubyte.sizeof);
				buffer~=varuint.encode(duration);
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, flags, buffer.length-ubyte.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				entityId=varuint.fromBuffer(buffer);
				if(buffer.length>=ubyte.sizeof){ effect=read!(ubyte, Endian.bigEndian)(buffer); }
				if(buffer.length>=ubyte.sizeof){ amplifier=read!(ubyte, Endian.bigEndian)(buffer); }
				duration=varuint.fromBuffer(buffer);
				if(buffer.length>=ubyte.sizeof){ flags=read!(ubyte, Endian.bigEndian)(buffer); }
				return this;
			}

		}

		static struct SetExperience {

			public enum uint packetId = 61;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public float experience;
			public uint level;
			public uint totalExperience;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer.length+=float.sizeof; write!(float, Endian.bigEndian)(buffer, experience, buffer.length-float.sizeof);
				buffer~=varuint.encode(level);
				buffer~=varuint.encode(totalExperience);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				if(buffer.length>=float.sizeof){ experience=read!(float, Endian.bigEndian)(buffer); }
				level=varuint.fromBuffer(buffer);
				totalExperience=varuint.fromBuffer(buffer);
				return this;
			}

		}

		static struct TimeUpdate {

			public enum uint packetId = 68;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public ulong worldAge;
			public long time;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer.length+=ulong.sizeof; write!(ulong, Endian.bigEndian)(buffer, worldAge, buffer.length-ulong.sizeof);
				buffer.length+=long.sizeof; write!(long, Endian.bigEndian)(buffer, time, buffer.length-long.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				if(buffer.length>=ulong.sizeof){ worldAge=read!(ulong, Endian.bigEndian)(buffer); }
				if(buffer.length>=long.sizeof){ time=read!(long, Endian.bigEndian)(buffer); }
				return this;
			}

		}

		static struct EntityHeadLook {

			public enum uint packetId = 52;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public uint entityId;
			public ubyte headYaw;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer~=varuint.encode(entityId);
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, headYaw, buffer.length-ubyte.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				entityId=varuint.fromBuffer(buffer);
				if(buffer.length>=ubyte.sizeof){ headYaw=read!(ubyte, Endian.bigEndian)(buffer); }
				return this;
			}

		}

		static struct WindowItems {

			public enum uint packetId = 20;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public ubyte window;
			public ushort count;
			public Types.Slot[] slots;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, window, buffer.length-ubyte.sizeof);
				buffer.length+=ushort.sizeof; write!(ushort, Endian.bigEndian)(buffer, count, buffer.length-ushort.sizeof);
				buffer.length+=ushort.sizeof; write!(ushort, Endian.bigEndian)(buffer, slots.length.to!ushort, buffer.length-ushort.sizeof);foreach(c2xvdHM;slots){ c2xvdHM.encode(buffer); }
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				if(buffer.length>=ubyte.sizeof){ window=read!(ubyte, Endian.bigEndian)(buffer); }
				if(buffer.length>=ushort.sizeof){ count=read!(ushort, Endian.bigEndian)(buffer); }
				if(buffer.length>=ushort.sizeof){ slots.length=read!(ushort, Endian.bigEndian)(buffer); }foreach(ref c2xvdHM;slots){ c2xvdHM.decode(buffer);}
				return this;
			}

		}

		static struct SpawnExperienceOrb {

			public enum uint packetId = 1;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public uint entityId;
			public Tuple!(double, "x", double, "y", double, "z") position;
			public ushort count;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer~=varuint.encode(entityId);
				buffer.length+=double.sizeof; write!(double, Endian.bigEndian)(buffer, position.x, buffer.length-double.sizeof);buffer.length+=double.sizeof; write!(double, Endian.bigEndian)(buffer, position.y, buffer.length-double.sizeof);buffer.length+=double.sizeof; write!(double, Endian.bigEndian)(buffer, position.z, buffer.length-double.sizeof);
				buffer.length+=ushort.sizeof; write!(ushort, Endian.bigEndian)(buffer, count, buffer.length-ushort.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				entityId=varuint.fromBuffer(buffer);
				if(buffer.length>=double.sizeof){ position.x=read!(double, Endian.bigEndian)(buffer); }if(buffer.length>=double.sizeof){ position.y=read!(double, Endian.bigEndian)(buffer); }if(buffer.length>=double.sizeof){ position.z=read!(double, Endian.bigEndian)(buffer); }
				if(buffer.length>=ushort.sizeof){ count=read!(ushort, Endian.bigEndian)(buffer); }
				return this;
			}

		}

		static struct TabCompleteServerbound {

			public enum uint packetId = 1;

			public enum bool clientbound = false;
			public enum bool serverbound = true;

			public string text;
			public bool command;
			public bool hasPosition;
			public ulong lookedAtBlock;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				ubyte[] dGV4dA=cast(ubyte[])text; buffer~=varuint.encode(dGV4dA.length.to!uint); buffer~=dGV4dA;
				buffer.length+=bool.sizeof; write!(bool, Endian.bigEndian)(buffer, command, buffer.length-bool.sizeof);
				buffer.length+=bool.sizeof; write!(bool, Endian.bigEndian)(buffer, hasPosition, buffer.length-bool.sizeof);
				buffer.length+=ulong.sizeof; write!(ulong, Endian.bigEndian)(buffer, lookedAtBlock, buffer.length-ulong.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				ubyte[] dGV4dA; dGV4dA.length=varuint.fromBuffer(buffer);if(buffer.length>=dGV4dA.length){ dGV4dA=buffer[0..dGV4dA.length]; buffer=buffer[dGV4dA.length..$]; }; text=cast(string)dGV4dA;
				if(buffer.length>=bool.sizeof){ command=read!(bool, Endian.bigEndian)(buffer); }
				if(buffer.length>=bool.sizeof){ hasPosition=read!(bool, Endian.bigEndian)(buffer); }
				if(buffer.length>=ulong.sizeof){ lookedAtBlock=read!(ulong, Endian.bigEndian)(buffer); }
				return this;
			}

		}

		static struct KeepAliveServerbound {

			public enum uint packetId = 11;

			public enum bool clientbound = false;
			public enum bool serverbound = true;

			public uint id;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer~=varuint.encode(id);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				id=varuint.fromBuffer(buffer);
				return this;
			}

		}

		static struct Map {

			public enum uint packetId = 36;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public uint mapId;
			public ubyte scale;
			public bool showIcons;
			public Types.Icon[] icons;
			public ubyte colums;
			public ubyte rows;
			public Tuple!(ubyte, "x", ubyte, "z") offset;
			public ubyte[] data;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer~=varuint.encode(mapId);
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, scale, buffer.length-ubyte.sizeof);
				buffer.length+=bool.sizeof; write!(bool, Endian.bigEndian)(buffer, showIcons, buffer.length-bool.sizeof);
				buffer~=varuint.encode(icons.length.to!uint);foreach(aWNvbnM;icons){ aWNvbnM.encode(buffer); }
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, colums, buffer.length-ubyte.sizeof);
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, rows, buffer.length-ubyte.sizeof);
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, offset.x, buffer.length-ubyte.sizeof);buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, offset.z, buffer.length-ubyte.sizeof);
				buffer~=varuint.encode(data.length.to!uint); buffer~=data;
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				mapId=varuint.fromBuffer(buffer);
				if(buffer.length>=ubyte.sizeof){ scale=read!(ubyte, Endian.bigEndian)(buffer); }
				if(buffer.length>=bool.sizeof){ showIcons=read!(bool, Endian.bigEndian)(buffer); }
				icons.length=varuint.fromBuffer(buffer);foreach(ref aWNvbnM;icons){ aWNvbnM.decode(buffer);}
				if(buffer.length>=ubyte.sizeof){ colums=read!(ubyte, Endian.bigEndian)(buffer); }
				if(buffer.length>=ubyte.sizeof){ rows=read!(ubyte, Endian.bigEndian)(buffer); }
				if(buffer.length>=ubyte.sizeof){ offset.x=read!(ubyte, Endian.bigEndian)(buffer); }if(buffer.length>=ubyte.sizeof){ offset.z=read!(ubyte, Endian.bigEndian)(buffer); }
				data.length=varuint.fromBuffer(buffer);if(buffer.length>=data.length){ data=buffer[0..data.length]; buffer=buffer[data.length..$]; }
				return this;
			}

		}

		static struct UseEntity {

			public enum uint packetId = 10;

			public enum bool clientbound = false;
			public enum bool serverbound = true;

			public uint target;
			public uint type;
			public Tuple!(float, "x", float, "y", float, "z") position;
			public uint hand;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer~=varuint.encode(target);
				buffer~=varuint.encode(type);
				buffer.length+=float.sizeof; write!(float, Endian.bigEndian)(buffer, position.x, buffer.length-float.sizeof);buffer.length+=float.sizeof; write!(float, Endian.bigEndian)(buffer, position.y, buffer.length-float.sizeof);buffer.length+=float.sizeof; write!(float, Endian.bigEndian)(buffer, position.z, buffer.length-float.sizeof);
				buffer~=varuint.encode(hand);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				target=varuint.fromBuffer(buffer);
				type=varuint.fromBuffer(buffer);
				if(buffer.length>=float.sizeof){ position.x=read!(float, Endian.bigEndian)(buffer); }if(buffer.length>=float.sizeof){ position.y=read!(float, Endian.bigEndian)(buffer); }if(buffer.length>=float.sizeof){ position.z=read!(float, Endian.bigEndian)(buffer); }
				hand=varuint.fromBuffer(buffer);
				return this;
			}

		}

		static struct UpdateHealth {

			public enum uint packetId = 62;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public float health;
			public uint hunger;
			public float saturation;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer.length+=float.sizeof; write!(float, Endian.bigEndian)(buffer, health, buffer.length-float.sizeof);
				buffer~=varuint.encode(hunger);
				buffer.length+=float.sizeof; write!(float, Endian.bigEndian)(buffer, saturation, buffer.length-float.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				if(buffer.length>=float.sizeof){ health=read!(float, Endian.bigEndian)(buffer); }
				hunger=varuint.fromBuffer(buffer);
				if(buffer.length>=float.sizeof){ saturation=read!(float, Endian.bigEndian)(buffer); }
				return this;
			}

		}

		static struct TabCompleteClientbound {

			public enum uint packetId = 14;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public string[] matches;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer~=varuint.encode(matches.length.to!uint);foreach(bWF0Y2hlcw;matches){ ubyte[] YldGMFkyaGxjdw=cast(ubyte[])bWF0Y2hlcw; buffer~=varuint.encode(YldGMFkyaGxjdw.length.to!uint); buffer~=YldGMFkyaGxjdw; }
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				matches.length=varuint.fromBuffer(buffer);foreach(ref bWF0Y2hlcw;matches){ ubyte[] YldGMFkyaGxjdw; YldGMFkyaGxjdw.length=varuint.fromBuffer(buffer);if(buffer.length>=YldGMFkyaGxjdw.length){ YldGMFkyaGxjdw=buffer[0..YldGMFkyaGxjdw.length]; buffer=buffer[YldGMFkyaGxjdw.length..$]; }; bWF0Y2hlcw=cast(string)YldGMFkyaGxjdw;}
				return this;
			}

		}

		static struct BossBar {

			public enum uint packetId = 12;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public UUID uuid;
			public uint action;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer~=uuid.data;
				buffer~=varuint.encode(action);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				if(buffer.length>=16){ ubyte[16] dXVpZA=buffer[0..16]; buffer=buffer[16..$]; uuid=UUID(dXVpZA); }
				action=varuint.fromBuffer(buffer);
				return this;
			}

			static struct UpdateStyle {

				public UUID uuid;
				public enum uint action = 4;
				public uint color;
				public uint division;

				public ubyte[] encode(bool write_id=true)() {
					ubyte[] buffer;
					static if(write_id){ buffer~=varuint.encode(packetId); }
					buffer~=uuid.data;
					buffer~=varuint.encode(action);
					buffer~=varuint.encode(color);
					buffer~=varuint.encode(division);
					return buffer;
				}

				public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
					static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
					if(buffer.length>=16){ ubyte[16] dXVpZA=buffer[0..16]; buffer=buffer[16..$]; uuid=UUID(dXVpZA); }
					uint __field_value; if(buffer.length>=uint.sizeof){ __field_value=read!(uint, Endian.bigEndian)(buffer); }
					color=varuint.fromBuffer(buffer);
					division=varuint.fromBuffer(buffer);
					return this;
				}

			}

			static struct Remove {

				public UUID uuid;
				public enum uint action = 1;

				public ubyte[] encode(bool write_id=true)() {
					ubyte[] buffer;
					static if(write_id){ buffer~=varuint.encode(packetId); }
					buffer~=uuid.data;
					buffer~=varuint.encode(action);
					return buffer;
				}

				public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
					static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
					if(buffer.length>=16){ ubyte[16] dXVpZA=buffer[0..16]; buffer=buffer[16..$]; uuid=UUID(dXVpZA); }
					uint __field_value; if(buffer.length>=uint.sizeof){ __field_value=read!(uint, Endian.bigEndian)(buffer); }
					return this;
				}

			}

			static struct UpdateTitle {

				public UUID uuid;
				public enum uint action = 3;
				public string title;

				public ubyte[] encode(bool write_id=true)() {
					ubyte[] buffer;
					static if(write_id){ buffer~=varuint.encode(packetId); }
					buffer~=uuid.data;
					buffer~=varuint.encode(action);
					ubyte[] dGl0bGU=cast(ubyte[])title; buffer~=varuint.encode(dGl0bGU.length.to!uint); buffer~=dGl0bGU;
					return buffer;
				}

				public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
					static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
					if(buffer.length>=16){ ubyte[16] dXVpZA=buffer[0..16]; buffer=buffer[16..$]; uuid=UUID(dXVpZA); }
					uint __field_value; if(buffer.length>=uint.sizeof){ __field_value=read!(uint, Endian.bigEndian)(buffer); }
					ubyte[] dGl0bGU; dGl0bGU.length=varuint.fromBuffer(buffer);if(buffer.length>=dGl0bGU.length){ dGl0bGU=buffer[0..dGl0bGU.length]; buffer=buffer[dGl0bGU.length..$]; }; title=cast(string)dGl0bGU;
					return this;
				}

			}

			static struct UpdateFlags {

				public UUID uuid;
				public enum uint action = 5;
				public ubyte flags;

				public ubyte[] encode(bool write_id=true)() {
					ubyte[] buffer;
					static if(write_id){ buffer~=varuint.encode(packetId); }
					buffer~=uuid.data;
					buffer~=varuint.encode(action);
					buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, flags, buffer.length-ubyte.sizeof);
					return buffer;
				}

				public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
					static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
					if(buffer.length>=16){ ubyte[16] dXVpZA=buffer[0..16]; buffer=buffer[16..$]; uuid=UUID(dXVpZA); }
					uint __field_value; if(buffer.length>=uint.sizeof){ __field_value=read!(uint, Endian.bigEndian)(buffer); }
					if(buffer.length>=ubyte.sizeof){ flags=read!(ubyte, Endian.bigEndian)(buffer); }
					return this;
				}

			}

			static struct UpdateHealth {

				public UUID uuid;
				public enum uint action = 2;
				public float health;

				public ubyte[] encode(bool write_id=true)() {
					ubyte[] buffer;
					static if(write_id){ buffer~=varuint.encode(packetId); }
					buffer~=uuid.data;
					buffer~=varuint.encode(action);
					buffer.length+=float.sizeof; write!(float, Endian.bigEndian)(buffer, health, buffer.length-float.sizeof);
					return buffer;
				}

				public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
					static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
					if(buffer.length>=16){ ubyte[16] dXVpZA=buffer[0..16]; buffer=buffer[16..$]; uuid=UUID(dXVpZA); }
					uint __field_value; if(buffer.length>=uint.sizeof){ __field_value=read!(uint, Endian.bigEndian)(buffer); }
					if(buffer.length>=float.sizeof){ health=read!(float, Endian.bigEndian)(buffer); }
					return this;
				}

			}

			static struct Add {

				public UUID uuid;
				public enum uint action = 0;
				public string title;
				public float health;
				public uint color;
				public uint division;
				public ubyte flags;

				public ubyte[] encode(bool write_id=true)() {
					ubyte[] buffer;
					static if(write_id){ buffer~=varuint.encode(packetId); }
					buffer~=uuid.data;
					buffer~=varuint.encode(action);
					ubyte[] dGl0bGU=cast(ubyte[])title; buffer~=varuint.encode(dGl0bGU.length.to!uint); buffer~=dGl0bGU;
					buffer.length+=float.sizeof; write!(float, Endian.bigEndian)(buffer, health, buffer.length-float.sizeof);
					buffer~=varuint.encode(color);
					buffer~=varuint.encode(division);
					buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, flags, buffer.length-ubyte.sizeof);
					return buffer;
				}

				public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
					static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
					if(buffer.length>=16){ ubyte[16] dXVpZA=buffer[0..16]; buffer=buffer[16..$]; uuid=UUID(dXVpZA); }
					uint __field_value; if(buffer.length>=uint.sizeof){ __field_value=read!(uint, Endian.bigEndian)(buffer); }
					ubyte[] dGl0bGU; dGl0bGU.length=varuint.fromBuffer(buffer);if(buffer.length>=dGl0bGU.length){ dGl0bGU=buffer[0..dGl0bGU.length]; buffer=buffer[dGl0bGU.length..$]; }; title=cast(string)dGl0bGU;
					if(buffer.length>=float.sizeof){ health=read!(float, Endian.bigEndian)(buffer); }
					color=varuint.fromBuffer(buffer);
					division=varuint.fromBuffer(buffer);
					if(buffer.length>=ubyte.sizeof){ flags=read!(ubyte, Endian.bigEndian)(buffer); }
					return this;
				}

			}

		}

		static struct UpdateSign {

			public enum uint packetId = 25;

			public enum bool clientbound = false;
			public enum bool serverbound = true;

			public ulong position;
			public string[4] lines;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer.length+=ulong.sizeof; write!(ulong, Endian.bigEndian)(buffer, position, buffer.length-ulong.sizeof);
				foreach(bGluZXM;lines){ ubyte[] YkdsdVpYTQ=cast(ubyte[])bGluZXM; buffer~=varuint.encode(YkdsdVpYTQ.length.to!uint); buffer~=YkdsdVpYTQ; }
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				if(buffer.length>=ulong.sizeof){ position=read!(ulong, Endian.bigEndian)(buffer); }
				foreach(ref bGluZXM;lines){ ubyte[] YkdsdVpYTQ; YkdsdVpYTQ.length=varuint.fromBuffer(buffer);if(buffer.length>=YkdsdVpYTQ.length){ YkdsdVpYTQ=buffer[0..YkdsdVpYTQ.length]; buffer=buffer[YkdsdVpYTQ.length..$]; }; bGluZXM=cast(string)YkdsdVpYTQ;}
				return this;
			}

		}

		static struct EntityMetadata {

			public enum uint packetId = 57;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public uint entityId;
			public ubyte[] metadata;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer~=varuint.encode(entityId);
				buffer~=metadata;
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				entityId=varuint.fromBuffer(buffer);
				metadata=buffer.dup; buffer.length=0;
				return this;
			}

		}

		static struct WorldBorder {

			public enum uint packetId = 53;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public uint action;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer~=varuint.encode(action);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				action=varuint.fromBuffer(buffer);
				return this;
			}

			static struct SetWarningTime {

				public enum uint action = 4;
				public uint warningTime;

				public ubyte[] encode(bool write_id=true)() {
					ubyte[] buffer;
					static if(write_id){ buffer~=varuint.encode(packetId); }
					buffer~=varuint.encode(action);
					buffer~=varuint.encode(warningTime);
					return buffer;
				}

				public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
					static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
					uint __field_value; if(buffer.length>=uint.sizeof){ __field_value=read!(uint, Endian.bigEndian)(buffer); }
					warningTime=varuint.fromBuffer(buffer);
					return this;
				}

			}

			static struct SetSize {

				public enum uint action = 0;
				public double diameter;

				public ubyte[] encode(bool write_id=true)() {
					ubyte[] buffer;
					static if(write_id){ buffer~=varuint.encode(packetId); }
					buffer~=varuint.encode(action);
					buffer.length+=double.sizeof; write!(double, Endian.bigEndian)(buffer, diameter, buffer.length-double.sizeof);
					return buffer;
				}

				public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
					static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
					uint __field_value; if(buffer.length>=uint.sizeof){ __field_value=read!(uint, Endian.bigEndian)(buffer); }
					if(buffer.length>=double.sizeof){ diameter=read!(double, Endian.bigEndian)(buffer); }
					return this;
				}

			}

			static struct LerpSize {

				public enum uint action = 1;
				public double oldDiameter;
				public double newDiameter;
				public ulong speed;

				public ubyte[] encode(bool write_id=true)() {
					ubyte[] buffer;
					static if(write_id){ buffer~=varuint.encode(packetId); }
					buffer~=varuint.encode(action);
					buffer.length+=double.sizeof; write!(double, Endian.bigEndian)(buffer, oldDiameter, buffer.length-double.sizeof);
					buffer.length+=double.sizeof; write!(double, Endian.bigEndian)(buffer, newDiameter, buffer.length-double.sizeof);
					buffer~=varulong.encode(speed);
					return buffer;
				}

				public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
					static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
					uint __field_value; if(buffer.length>=uint.sizeof){ __field_value=read!(uint, Endian.bigEndian)(buffer); }
					if(buffer.length>=double.sizeof){ oldDiameter=read!(double, Endian.bigEndian)(buffer); }
					if(buffer.length>=double.sizeof){ newDiameter=read!(double, Endian.bigEndian)(buffer); }
					speed=varulong.fromBuffer(buffer);
					return this;
				}

			}

			static struct SetCenter {

				public enum uint action = 2;
				public Tuple!(double, "x", double, "z") center;

				public ubyte[] encode(bool write_id=true)() {
					ubyte[] buffer;
					static if(write_id){ buffer~=varuint.encode(packetId); }
					buffer~=varuint.encode(action);
					buffer.length+=double.sizeof; write!(double, Endian.bigEndian)(buffer, center.x, buffer.length-double.sizeof);buffer.length+=double.sizeof; write!(double, Endian.bigEndian)(buffer, center.z, buffer.length-double.sizeof);
					return buffer;
				}

				public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
					static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
					uint __field_value; if(buffer.length>=uint.sizeof){ __field_value=read!(uint, Endian.bigEndian)(buffer); }
					if(buffer.length>=double.sizeof){ center.x=read!(double, Endian.bigEndian)(buffer); }if(buffer.length>=double.sizeof){ center.z=read!(double, Endian.bigEndian)(buffer); }
					return this;
				}

			}

			static struct Initialize {

				public enum uint action = 3;
				public Tuple!(double, "x", double, "z") center;
				public double oldDiameter;
				public double newDiameter;
				public ulong speed;
				public uint portalTeleportBoundary;
				public uint warningTime;
				public uint warningBlocks;

				public ubyte[] encode(bool write_id=true)() {
					ubyte[] buffer;
					static if(write_id){ buffer~=varuint.encode(packetId); }
					buffer~=varuint.encode(action);
					buffer.length+=double.sizeof; write!(double, Endian.bigEndian)(buffer, center.x, buffer.length-double.sizeof);buffer.length+=double.sizeof; write!(double, Endian.bigEndian)(buffer, center.z, buffer.length-double.sizeof);
					buffer.length+=double.sizeof; write!(double, Endian.bigEndian)(buffer, oldDiameter, buffer.length-double.sizeof);
					buffer.length+=double.sizeof; write!(double, Endian.bigEndian)(buffer, newDiameter, buffer.length-double.sizeof);
					buffer~=varulong.encode(speed);
					buffer~=varuint.encode(portalTeleportBoundary);
					buffer~=varuint.encode(warningTime);
					buffer~=varuint.encode(warningBlocks);
					return buffer;
				}

				public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
					static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
					uint __field_value; if(buffer.length>=uint.sizeof){ __field_value=read!(uint, Endian.bigEndian)(buffer); }
					if(buffer.length>=double.sizeof){ center.x=read!(double, Endian.bigEndian)(buffer); }if(buffer.length>=double.sizeof){ center.z=read!(double, Endian.bigEndian)(buffer); }
					if(buffer.length>=double.sizeof){ oldDiameter=read!(double, Endian.bigEndian)(buffer); }
					if(buffer.length>=double.sizeof){ newDiameter=read!(double, Endian.bigEndian)(buffer); }
					speed=varulong.fromBuffer(buffer);
					portalTeleportBoundary=varuint.fromBuffer(buffer);
					warningTime=varuint.fromBuffer(buffer);
					warningBlocks=varuint.fromBuffer(buffer);
					return this;
				}

			}

			static struct SetWarningBlocks {

				public enum uint action = 5;
				public uint warningBlocks;

				public ubyte[] encode(bool write_id=true)() {
					ubyte[] buffer;
					static if(write_id){ buffer~=varuint.encode(packetId); }
					buffer~=varuint.encode(action);
					buffer~=varuint.encode(warningBlocks);
					return buffer;
				}

				public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
					static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
					uint __field_value; if(buffer.length>=uint.sizeof){ __field_value=read!(uint, Endian.bigEndian)(buffer); }
					warningBlocks=varuint.fromBuffer(buffer);
					return this;
				}

			}

		}

		static struct UnloadChunk {

			public enum uint packetId = 29;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public Tuple!(int, "x", int, "z") position;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer.length+=int.sizeof; write!(int, Endian.bigEndian)(buffer, position.x, buffer.length-int.sizeof);buffer.length+=int.sizeof; write!(int, Endian.bigEndian)(buffer, position.z, buffer.length-int.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				if(buffer.length>=int.sizeof){ position.x=read!(int, Endian.bigEndian)(buffer); }if(buffer.length>=int.sizeof){ position.z=read!(int, Endian.bigEndian)(buffer); }
				return this;
			}

		}

		static struct CloseWindowServerboound {

			public enum uint packetId = 8;

			public enum bool clientbound = false;
			public enum bool serverbound = true;

			public ubyte window;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, window, buffer.length-ubyte.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				if(buffer.length>=ubyte.sizeof){ window=read!(ubyte, Endian.bigEndian)(buffer); }
				return this;
			}

		}

		static struct PlayerDigging {

			public enum uint packetId = 19;

			public enum bool clientbound = false;
			public enum bool serverbound = true;

			public uint status;
			public ulong position;
			public ubyte face;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer~=varuint.encode(status);
				buffer.length+=ulong.sizeof; write!(ulong, Endian.bigEndian)(buffer, position, buffer.length-ulong.sizeof);
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, face, buffer.length-ubyte.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				status=varuint.fromBuffer(buffer);
				if(buffer.length>=ulong.sizeof){ position=read!(ulong, Endian.bigEndian)(buffer); }
				if(buffer.length>=ubyte.sizeof){ face=read!(ubyte, Endian.bigEndian)(buffer); }
				return this;
			}

		}

		static struct PluginMessageServerbound {

			public enum uint packetId = 9;

			public enum bool clientbound = false;
			public enum bool serverbound = true;

			public string channel;
			public ubyte[] data;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				ubyte[] Y2hhbm5lbA=cast(ubyte[])channel; buffer~=varuint.encode(Y2hhbm5lbA.length.to!uint); buffer~=Y2hhbm5lbA;
				buffer~=data;
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				ubyte[] Y2hhbm5lbA; Y2hhbm5lbA.length=varuint.fromBuffer(buffer);if(buffer.length>=Y2hhbm5lbA.length){ Y2hhbm5lbA=buffer[0..Y2hhbm5lbA.length]; buffer=buffer[Y2hhbm5lbA.length..$]; }; channel=cast(string)Y2hhbm5lbA;
				data=buffer.dup; buffer.length=0;
				return this;
			}

		}

		static struct AnimationServerbound {

			public enum uint packetId = 26;

			public enum bool clientbound = false;
			public enum bool serverbound = true;

			public uint hand;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer~=varuint.encode(hand);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				hand=varuint.fromBuffer(buffer);
				return this;
			}

		}

		static struct SetSlot {

			public enum uint packetId = 22;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public ubyte window;
			public ushort slot;
			public Types.Slot item;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, window, buffer.length-ubyte.sizeof);
				buffer.length+=ushort.sizeof; write!(ushort, Endian.bigEndian)(buffer, slot, buffer.length-ushort.sizeof);
				item.encode(buffer);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				if(buffer.length>=ubyte.sizeof){ window=read!(ubyte, Endian.bigEndian)(buffer); }
				if(buffer.length>=ushort.sizeof){ slot=read!(ushort, Endian.bigEndian)(buffer); }
				item.decode(buffer);
				return this;
			}

		}

		static struct ScoreboardObjective {

			public enum uint packetId = 63;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public string name;
			public ubyte mode;
			public string value;
			public string type;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				ubyte[] bmFtZQ=cast(ubyte[])name; buffer~=varuint.encode(bmFtZQ.length.to!uint); buffer~=bmFtZQ;
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, mode, buffer.length-ubyte.sizeof);
				ubyte[] dmFsdWU=cast(ubyte[])value; buffer~=varuint.encode(dmFsdWU.length.to!uint); buffer~=dmFsdWU;
				ubyte[] dHlwZQ=cast(ubyte[])type; buffer~=varuint.encode(dHlwZQ.length.to!uint); buffer~=dHlwZQ;
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				ubyte[] bmFtZQ; bmFtZQ.length=varuint.fromBuffer(buffer);if(buffer.length>=bmFtZQ.length){ bmFtZQ=buffer[0..bmFtZQ.length]; buffer=buffer[bmFtZQ.length..$]; }; name=cast(string)bmFtZQ;
				if(buffer.length>=ubyte.sizeof){ mode=read!(ubyte, Endian.bigEndian)(buffer); }
				ubyte[] dmFsdWU; dmFsdWU.length=varuint.fromBuffer(buffer);if(buffer.length>=dmFsdWU.length){ dmFsdWU=buffer[0..dmFsdWU.length]; buffer=buffer[dmFsdWU.length..$]; }; value=cast(string)dmFsdWU;
				ubyte[] dHlwZQ; dHlwZQ.length=varuint.fromBuffer(buffer);if(buffer.length>=dHlwZQ.length){ dHlwZQ=buffer[0..dHlwZQ.length]; buffer=buffer[dHlwZQ.length..$]; }; type=cast(string)dHlwZQ;
				return this;
			}

		}

		static struct PlayerBlockPlacement {

			public enum uint packetId = 28;

			public enum bool clientbound = false;
			public enum bool serverbound = true;

			public ulong position;
			public uint face;
			public uint hand;
			public Tuple!(float, "x", float, "y", float, "z") cursor;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer.length+=ulong.sizeof; write!(ulong, Endian.bigEndian)(buffer, position, buffer.length-ulong.sizeof);
				buffer~=varuint.encode(face);
				buffer~=varuint.encode(hand);
				buffer.length+=float.sizeof; write!(float, Endian.bigEndian)(buffer, cursor.x, buffer.length-float.sizeof);buffer.length+=float.sizeof; write!(float, Endian.bigEndian)(buffer, cursor.y, buffer.length-float.sizeof);buffer.length+=float.sizeof; write!(float, Endian.bigEndian)(buffer, cursor.z, buffer.length-float.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				if(buffer.length>=ulong.sizeof){ position=read!(ulong, Endian.bigEndian)(buffer); }
				face=varuint.fromBuffer(buffer);
				hand=varuint.fromBuffer(buffer);
				if(buffer.length>=float.sizeof){ cursor.x=read!(float, Endian.bigEndian)(buffer); }if(buffer.length>=float.sizeof){ cursor.y=read!(float, Endian.bigEndian)(buffer); }if(buffer.length>=float.sizeof){ cursor.z=read!(float, Endian.bigEndian)(buffer); }
				return this;
			}

		}

		static struct EntityLookAndRelativeMove {

			public enum uint packetId = 38;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public uint entityId;
			public Tuple!(short, "x", short, "y", short, "z") delta;
			public ubyte yaw;
			public ubyte pitch;
			public bool onGround;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer~=varuint.encode(entityId);
				buffer.length+=short.sizeof; write!(short, Endian.bigEndian)(buffer, delta.x, buffer.length-short.sizeof);buffer.length+=short.sizeof; write!(short, Endian.bigEndian)(buffer, delta.y, buffer.length-short.sizeof);buffer.length+=short.sizeof; write!(short, Endian.bigEndian)(buffer, delta.z, buffer.length-short.sizeof);
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, yaw, buffer.length-ubyte.sizeof);
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, pitch, buffer.length-ubyte.sizeof);
				buffer.length+=bool.sizeof; write!(bool, Endian.bigEndian)(buffer, onGround, buffer.length-bool.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				entityId=varuint.fromBuffer(buffer);
				if(buffer.length>=short.sizeof){ delta.x=read!(short, Endian.bigEndian)(buffer); }if(buffer.length>=short.sizeof){ delta.y=read!(short, Endian.bigEndian)(buffer); }if(buffer.length>=short.sizeof){ delta.z=read!(short, Endian.bigEndian)(buffer); }
				if(buffer.length>=ubyte.sizeof){ yaw=read!(ubyte, Endian.bigEndian)(buffer); }
				if(buffer.length>=ubyte.sizeof){ pitch=read!(ubyte, Endian.bigEndian)(buffer); }
				if(buffer.length>=bool.sizeof){ onGround=read!(bool, Endian.bigEndian)(buffer); }
				return this;
			}

		}

		static struct PlayerAbilitiesServerbound {

			public enum uint packetId = 18;

			public enum bool clientbound = false;
			public enum bool serverbound = true;

			public ubyte flags;
			public float flyingSpeed;
			public float walkingSpeed;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, flags, buffer.length-ubyte.sizeof);
				buffer.length+=float.sizeof; write!(float, Endian.bigEndian)(buffer, flyingSpeed, buffer.length-float.sizeof);
				buffer.length+=float.sizeof; write!(float, Endian.bigEndian)(buffer, walkingSpeed, buffer.length-float.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				if(buffer.length>=ubyte.sizeof){ flags=read!(ubyte, Endian.bigEndian)(buffer); }
				if(buffer.length>=float.sizeof){ flyingSpeed=read!(float, Endian.bigEndian)(buffer); }
				if(buffer.length>=float.sizeof){ walkingSpeed=read!(float, Endian.bigEndian)(buffer); }
				return this;
			}

		}

		static struct PlayerPosition {

			public enum uint packetId = 12;

			public enum bool clientbound = false;
			public enum bool serverbound = true;

			public Tuple!(double, "x", double, "y", double, "z") position;
			public bool onGround;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer.length+=double.sizeof; write!(double, Endian.bigEndian)(buffer, position.x, buffer.length-double.sizeof);buffer.length+=double.sizeof; write!(double, Endian.bigEndian)(buffer, position.y, buffer.length-double.sizeof);buffer.length+=double.sizeof; write!(double, Endian.bigEndian)(buffer, position.z, buffer.length-double.sizeof);
				buffer.length+=bool.sizeof; write!(bool, Endian.bigEndian)(buffer, onGround, buffer.length-bool.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				if(buffer.length>=double.sizeof){ position.x=read!(double, Endian.bigEndian)(buffer); }if(buffer.length>=double.sizeof){ position.y=read!(double, Endian.bigEndian)(buffer); }if(buffer.length>=double.sizeof){ position.z=read!(double, Endian.bigEndian)(buffer); }
				if(buffer.length>=bool.sizeof){ onGround=read!(bool, Endian.bigEndian)(buffer); }
				return this;
			}

		}

		static struct ClickWindow {

			public enum uint packetId = 7;

			public enum bool clientbound = false;
			public enum bool serverbound = true;

			public ubyte window;
			public ushort slot;
			public ubyte button;
			public ushort action;
			public uint mode;
			public Types.Slot clickedItem;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, window, buffer.length-ubyte.sizeof);
				buffer.length+=ushort.sizeof; write!(ushort, Endian.bigEndian)(buffer, slot, buffer.length-ushort.sizeof);
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, button, buffer.length-ubyte.sizeof);
				buffer.length+=ushort.sizeof; write!(ushort, Endian.bigEndian)(buffer, action, buffer.length-ushort.sizeof);
				buffer~=varuint.encode(mode);
				clickedItem.encode(buffer);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				if(buffer.length>=ubyte.sizeof){ window=read!(ubyte, Endian.bigEndian)(buffer); }
				if(buffer.length>=ushort.sizeof){ slot=read!(ushort, Endian.bigEndian)(buffer); }
				if(buffer.length>=ubyte.sizeof){ button=read!(ubyte, Endian.bigEndian)(buffer); }
				if(buffer.length>=ushort.sizeof){ action=read!(ushort, Endian.bigEndian)(buffer); }
				mode=varuint.fromBuffer(buffer);
				clickedItem.decode(buffer);
				return this;
			}

		}

		static struct DisplayScoreboard {

			public enum uint packetId = 56;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public ubyte position;
			public string scoreName;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, position, buffer.length-ubyte.sizeof);
				ubyte[] c2NvcmVOYW1l=cast(ubyte[])scoreName; buffer~=varuint.encode(c2NvcmVOYW1l.length.to!uint); buffer~=c2NvcmVOYW1l;
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				if(buffer.length>=ubyte.sizeof){ position=read!(ubyte, Endian.bigEndian)(buffer); }
				ubyte[] c2NvcmVOYW1l; c2NvcmVOYW1l.length=varuint.fromBuffer(buffer);if(buffer.length>=c2NvcmVOYW1l.length){ c2NvcmVOYW1l=buffer[0..c2NvcmVOYW1l.length]; buffer=buffer[c2NvcmVOYW1l.length..$]; }; scoreName=cast(string)c2NvcmVOYW1l;
				return this;
			}

		}

		static struct Entity {

			public enum uint packetId = 40;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public uint entityId;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer~=varuint.encode(entityId);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				entityId=varuint.fromBuffer(buffer);
				return this;
			}

		}

		static struct Teams {

			public enum uint packetId = 65;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public string name;
			public ubyte mode;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				ubyte[] bmFtZQ=cast(ubyte[])name; buffer~=varuint.encode(bmFtZQ.length.to!uint); buffer~=bmFtZQ;
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, mode, buffer.length-ubyte.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				ubyte[] bmFtZQ; bmFtZQ.length=varuint.fromBuffer(buffer);if(buffer.length>=bmFtZQ.length){ bmFtZQ=buffer[0..bmFtZQ.length]; buffer=buffer[bmFtZQ.length..$]; }; name=cast(string)bmFtZQ;
				if(buffer.length>=ubyte.sizeof){ mode=read!(ubyte, Endian.bigEndian)(buffer); }
				return this;
			}

			static struct UpdateTeamInfo {

				public string name;
				public enum ubyte mode = 2;
				public string displayName;
				public string prefix;
				public string suffix;
				public ubyte friendlyFlags;
				public string nametagsVisibility;
				public string collisionRule;
				public ubyte color;

				public ubyte[] encode(bool write_id=true)() {
					ubyte[] buffer;
					static if(write_id){ buffer~=varuint.encode(packetId); }
					ubyte[] bmFtZQ=cast(ubyte[])name; buffer~=varuint.encode(bmFtZQ.length.to!uint); buffer~=bmFtZQ;
					buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, mode, buffer.length-ubyte.sizeof);
					ubyte[] ZGlzcGxheU5hbWU=cast(ubyte[])displayName; buffer~=varuint.encode(ZGlzcGxheU5hbWU.length.to!uint); buffer~=ZGlzcGxheU5hbWU;
					ubyte[] cHJlZml4=cast(ubyte[])prefix; buffer~=varuint.encode(cHJlZml4.length.to!uint); buffer~=cHJlZml4;
					ubyte[] c3VmZml4=cast(ubyte[])suffix; buffer~=varuint.encode(c3VmZml4.length.to!uint); buffer~=c3VmZml4;
					buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, friendlyFlags, buffer.length-ubyte.sizeof);
					ubyte[] bmFtZXRhZ3NWaXNp=cast(ubyte[])nametagsVisibility; buffer~=varuint.encode(bmFtZXRhZ3NWaXNp.length.to!uint); buffer~=bmFtZXRhZ3NWaXNp;
					ubyte[] Y29sbGlzaW9uUnVs=cast(ubyte[])collisionRule; buffer~=varuint.encode(Y29sbGlzaW9uUnVs.length.to!uint); buffer~=Y29sbGlzaW9uUnVs;
					buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, color, buffer.length-ubyte.sizeof);
					return buffer;
				}

				public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
					static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
					ubyte[] bmFtZQ; bmFtZQ.length=varuint.fromBuffer(buffer);if(buffer.length>=bmFtZQ.length){ bmFtZQ=buffer[0..bmFtZQ.length]; buffer=buffer[bmFtZQ.length..$]; }; name=cast(string)bmFtZQ;
					ubyte __field_value; if(buffer.length>=ubyte.sizeof){ __field_value=read!(ubyte, Endian.bigEndian)(buffer); }
					ubyte[] ZGlzcGxheU5hbWU; ZGlzcGxheU5hbWU.length=varuint.fromBuffer(buffer);if(buffer.length>=ZGlzcGxheU5hbWU.length){ ZGlzcGxheU5hbWU=buffer[0..ZGlzcGxheU5hbWU.length]; buffer=buffer[ZGlzcGxheU5hbWU.length..$]; }; displayName=cast(string)ZGlzcGxheU5hbWU;
					ubyte[] cHJlZml4; cHJlZml4.length=varuint.fromBuffer(buffer);if(buffer.length>=cHJlZml4.length){ cHJlZml4=buffer[0..cHJlZml4.length]; buffer=buffer[cHJlZml4.length..$]; }; prefix=cast(string)cHJlZml4;
					ubyte[] c3VmZml4; c3VmZml4.length=varuint.fromBuffer(buffer);if(buffer.length>=c3VmZml4.length){ c3VmZml4=buffer[0..c3VmZml4.length]; buffer=buffer[c3VmZml4.length..$]; }; suffix=cast(string)c3VmZml4;
					if(buffer.length>=ubyte.sizeof){ friendlyFlags=read!(ubyte, Endian.bigEndian)(buffer); }
					ubyte[] bmFtZXRhZ3NWaXNp; bmFtZXRhZ3NWaXNp.length=varuint.fromBuffer(buffer);if(buffer.length>=bmFtZXRhZ3NWaXNp.length){ bmFtZXRhZ3NWaXNp=buffer[0..bmFtZXRhZ3NWaXNp.length]; buffer=buffer[bmFtZXRhZ3NWaXNp.length..$]; }; nametagsVisibility=cast(string)bmFtZXRhZ3NWaXNp;
					ubyte[] Y29sbGlzaW9uUnVs; Y29sbGlzaW9uUnVs.length=varuint.fromBuffer(buffer);if(buffer.length>=Y29sbGlzaW9uUnVs.length){ Y29sbGlzaW9uUnVs=buffer[0..Y29sbGlzaW9uUnVs.length]; buffer=buffer[Y29sbGlzaW9uUnVs.length..$]; }; collisionRule=cast(string)Y29sbGlzaW9uUnVs;
					if(buffer.length>=ubyte.sizeof){ color=read!(ubyte, Endian.bigEndian)(buffer); }
					return this;
				}

			}

			static struct CreateTeam {

				public string name;
				public enum ubyte mode = 0;
				public string displayName;
				public string prefix;
				public string suffix;
				public ubyte friendlyFlags;
				public string nametagsVisibility;
				public string collisionRule;
				public ubyte color;
				public string[] players;

				public ubyte[] encode(bool write_id=true)() {
					ubyte[] buffer;
					static if(write_id){ buffer~=varuint.encode(packetId); }
					ubyte[] bmFtZQ=cast(ubyte[])name; buffer~=varuint.encode(bmFtZQ.length.to!uint); buffer~=bmFtZQ;
					buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, mode, buffer.length-ubyte.sizeof);
					ubyte[] ZGlzcGxheU5hbWU=cast(ubyte[])displayName; buffer~=varuint.encode(ZGlzcGxheU5hbWU.length.to!uint); buffer~=ZGlzcGxheU5hbWU;
					ubyte[] cHJlZml4=cast(ubyte[])prefix; buffer~=varuint.encode(cHJlZml4.length.to!uint); buffer~=cHJlZml4;
					ubyte[] c3VmZml4=cast(ubyte[])suffix; buffer~=varuint.encode(c3VmZml4.length.to!uint); buffer~=c3VmZml4;
					buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, friendlyFlags, buffer.length-ubyte.sizeof);
					ubyte[] bmFtZXRhZ3NWaXNp=cast(ubyte[])nametagsVisibility; buffer~=varuint.encode(bmFtZXRhZ3NWaXNp.length.to!uint); buffer~=bmFtZXRhZ3NWaXNp;
					ubyte[] Y29sbGlzaW9uUnVs=cast(ubyte[])collisionRule; buffer~=varuint.encode(Y29sbGlzaW9uUnVs.length.to!uint); buffer~=Y29sbGlzaW9uUnVs;
					buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, color, buffer.length-ubyte.sizeof);
					buffer~=varuint.encode(players.length.to!uint);foreach(cGxheWVycw;players){ ubyte[] Y0d4aGVXVnljdw=cast(ubyte[])cGxheWVycw; buffer~=varuint.encode(Y0d4aGVXVnljdw.length.to!uint); buffer~=Y0d4aGVXVnljdw; }
					return buffer;
				}

				public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
					static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
					ubyte[] bmFtZQ; bmFtZQ.length=varuint.fromBuffer(buffer);if(buffer.length>=bmFtZQ.length){ bmFtZQ=buffer[0..bmFtZQ.length]; buffer=buffer[bmFtZQ.length..$]; }; name=cast(string)bmFtZQ;
					ubyte __field_value; if(buffer.length>=ubyte.sizeof){ __field_value=read!(ubyte, Endian.bigEndian)(buffer); }
					ubyte[] ZGlzcGxheU5hbWU; ZGlzcGxheU5hbWU.length=varuint.fromBuffer(buffer);if(buffer.length>=ZGlzcGxheU5hbWU.length){ ZGlzcGxheU5hbWU=buffer[0..ZGlzcGxheU5hbWU.length]; buffer=buffer[ZGlzcGxheU5hbWU.length..$]; }; displayName=cast(string)ZGlzcGxheU5hbWU;
					ubyte[] cHJlZml4; cHJlZml4.length=varuint.fromBuffer(buffer);if(buffer.length>=cHJlZml4.length){ cHJlZml4=buffer[0..cHJlZml4.length]; buffer=buffer[cHJlZml4.length..$]; }; prefix=cast(string)cHJlZml4;
					ubyte[] c3VmZml4; c3VmZml4.length=varuint.fromBuffer(buffer);if(buffer.length>=c3VmZml4.length){ c3VmZml4=buffer[0..c3VmZml4.length]; buffer=buffer[c3VmZml4.length..$]; }; suffix=cast(string)c3VmZml4;
					if(buffer.length>=ubyte.sizeof){ friendlyFlags=read!(ubyte, Endian.bigEndian)(buffer); }
					ubyte[] bmFtZXRhZ3NWaXNp; bmFtZXRhZ3NWaXNp.length=varuint.fromBuffer(buffer);if(buffer.length>=bmFtZXRhZ3NWaXNp.length){ bmFtZXRhZ3NWaXNp=buffer[0..bmFtZXRhZ3NWaXNp.length]; buffer=buffer[bmFtZXRhZ3NWaXNp.length..$]; }; nametagsVisibility=cast(string)bmFtZXRhZ3NWaXNp;
					ubyte[] Y29sbGlzaW9uUnVs; Y29sbGlzaW9uUnVs.length=varuint.fromBuffer(buffer);if(buffer.length>=Y29sbGlzaW9uUnVs.length){ Y29sbGlzaW9uUnVs=buffer[0..Y29sbGlzaW9uUnVs.length]; buffer=buffer[Y29sbGlzaW9uUnVs.length..$]; }; collisionRule=cast(string)Y29sbGlzaW9uUnVs;
					if(buffer.length>=ubyte.sizeof){ color=read!(ubyte, Endian.bigEndian)(buffer); }
					players.length=varuint.fromBuffer(buffer);foreach(ref cGxheWVycw;players){ ubyte[] Y0d4aGVXVnljdw; Y0d4aGVXVnljdw.length=varuint.fromBuffer(buffer);if(buffer.length>=Y0d4aGVXVnljdw.length){ Y0d4aGVXVnljdw=buffer[0..Y0d4aGVXVnljdw.length]; buffer=buffer[Y0d4aGVXVnljdw.length..$]; }; cGxheWVycw=cast(string)Y0d4aGVXVnljdw;}
					return this;
				}

			}

			static struct AddPlayers {

				public string name;
				public enum ubyte mode = 3;
				public string[] players;

				public ubyte[] encode(bool write_id=true)() {
					ubyte[] buffer;
					static if(write_id){ buffer~=varuint.encode(packetId); }
					ubyte[] bmFtZQ=cast(ubyte[])name; buffer~=varuint.encode(bmFtZQ.length.to!uint); buffer~=bmFtZQ;
					buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, mode, buffer.length-ubyte.sizeof);
					buffer~=varuint.encode(players.length.to!uint);foreach(cGxheWVycw;players){ ubyte[] Y0d4aGVXVnljdw=cast(ubyte[])cGxheWVycw; buffer~=varuint.encode(Y0d4aGVXVnljdw.length.to!uint); buffer~=Y0d4aGVXVnljdw; }
					return buffer;
				}

				public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
					static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
					ubyte[] bmFtZQ; bmFtZQ.length=varuint.fromBuffer(buffer);if(buffer.length>=bmFtZQ.length){ bmFtZQ=buffer[0..bmFtZQ.length]; buffer=buffer[bmFtZQ.length..$]; }; name=cast(string)bmFtZQ;
					ubyte __field_value; if(buffer.length>=ubyte.sizeof){ __field_value=read!(ubyte, Endian.bigEndian)(buffer); }
					players.length=varuint.fromBuffer(buffer);foreach(ref cGxheWVycw;players){ ubyte[] Y0d4aGVXVnljdw; Y0d4aGVXVnljdw.length=varuint.fromBuffer(buffer);if(buffer.length>=Y0d4aGVXVnljdw.length){ Y0d4aGVXVnljdw=buffer[0..Y0d4aGVXVnljdw.length]; buffer=buffer[Y0d4aGVXVnljdw.length..$]; }; cGxheWVycw=cast(string)Y0d4aGVXVnljdw;}
					return this;
				}

			}

			static struct RemovePlayers {

				public string name;
				public enum ubyte mode = 4;
				public string[] players;

				public ubyte[] encode(bool write_id=true)() {
					ubyte[] buffer;
					static if(write_id){ buffer~=varuint.encode(packetId); }
					ubyte[] bmFtZQ=cast(ubyte[])name; buffer~=varuint.encode(bmFtZQ.length.to!uint); buffer~=bmFtZQ;
					buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, mode, buffer.length-ubyte.sizeof);
					buffer~=varuint.encode(players.length.to!uint);foreach(cGxheWVycw;players){ ubyte[] Y0d4aGVXVnljdw=cast(ubyte[])cGxheWVycw; buffer~=varuint.encode(Y0d4aGVXVnljdw.length.to!uint); buffer~=Y0d4aGVXVnljdw; }
					return buffer;
				}

				public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
					static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
					ubyte[] bmFtZQ; bmFtZQ.length=varuint.fromBuffer(buffer);if(buffer.length>=bmFtZQ.length){ bmFtZQ=buffer[0..bmFtZQ.length]; buffer=buffer[bmFtZQ.length..$]; }; name=cast(string)bmFtZQ;
					ubyte __field_value; if(buffer.length>=ubyte.sizeof){ __field_value=read!(ubyte, Endian.bigEndian)(buffer); }
					players.length=varuint.fromBuffer(buffer);foreach(ref cGxheWVycw;players){ ubyte[] Y0d4aGVXVnljdw; Y0d4aGVXVnljdw.length=varuint.fromBuffer(buffer);if(buffer.length>=Y0d4aGVXVnljdw.length){ Y0d4aGVXVnljdw=buffer[0..Y0d4aGVXVnljdw.length]; buffer=buffer[Y0d4aGVXVnljdw.length..$]; }; cGxheWVycw=cast(string)Y0d4aGVXVnljdw;}
					return this;
				}

			}

			static struct RemoveTeam {

				public string name;
				public enum ubyte mode = 1;

				public ubyte[] encode(bool write_id=true)() {
					ubyte[] buffer;
					static if(write_id){ buffer~=varuint.encode(packetId); }
					ubyte[] bmFtZQ=cast(ubyte[])name; buffer~=varuint.encode(bmFtZQ.length.to!uint); buffer~=bmFtZQ;
					buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, mode, buffer.length-ubyte.sizeof);
					return buffer;
				}

				public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
					static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
					ubyte[] bmFtZQ; bmFtZQ.length=varuint.fromBuffer(buffer);if(buffer.length>=bmFtZQ.length){ bmFtZQ=buffer[0..bmFtZQ.length]; buffer=buffer[bmFtZQ.length..$]; }; name=cast(string)bmFtZQ;
					ubyte __field_value; if(buffer.length>=ubyte.sizeof){ __field_value=read!(ubyte, Endian.bigEndian)(buffer); }
					return this;
				}

			}

		}

		static struct Explosion {

			public enum uint packetId = 28;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public Tuple!(float, "x", float, "y", float, "z") position;
			public float radius;
			public Tuple!(byte, "x", byte, "y", byte, "z")[] records;
			public Tuple!(float, "x", float, "y", float, "z") motion;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer.length+=float.sizeof; write!(float, Endian.bigEndian)(buffer, position.x, buffer.length-float.sizeof);buffer.length+=float.sizeof; write!(float, Endian.bigEndian)(buffer, position.y, buffer.length-float.sizeof);buffer.length+=float.sizeof; write!(float, Endian.bigEndian)(buffer, position.z, buffer.length-float.sizeof);
				buffer.length+=float.sizeof; write!(float, Endian.bigEndian)(buffer, radius, buffer.length-float.sizeof);
				buffer.length+=uint.sizeof; write!(uint, Endian.bigEndian)(buffer, records.length.to!uint, buffer.length-uint.sizeof);foreach(cmVjb3Jkcw;records){ cmVjb3Jkcw.encode(buffer); }
				buffer.length+=float.sizeof; write!(float, Endian.bigEndian)(buffer, motion.x, buffer.length-float.sizeof);buffer.length+=float.sizeof; write!(float, Endian.bigEndian)(buffer, motion.y, buffer.length-float.sizeof);buffer.length+=float.sizeof; write!(float, Endian.bigEndian)(buffer, motion.z, buffer.length-float.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				if(buffer.length>=float.sizeof){ position.x=read!(float, Endian.bigEndian)(buffer); }if(buffer.length>=float.sizeof){ position.y=read!(float, Endian.bigEndian)(buffer); }if(buffer.length>=float.sizeof){ position.z=read!(float, Endian.bigEndian)(buffer); }
				if(buffer.length>=float.sizeof){ radius=read!(float, Endian.bigEndian)(buffer); }
				if(buffer.length>=uint.sizeof){ records.length=read!(uint, Endian.bigEndian)(buffer); }foreach(ref cmVjb3Jkcw;records){ cmVjb3Jkcw.decode(buffer);}
				if(buffer.length>=float.sizeof){ motion.x=read!(float, Endian.bigEndian)(buffer); }if(buffer.length>=float.sizeof){ motion.y=read!(float, Endian.bigEndian)(buffer); }if(buffer.length>=float.sizeof){ motion.z=read!(float, Endian.bigEndian)(buffer); }
				return this;
			}

		}

		static struct VehicleMoveServerbound {

			public enum uint packetId = 16;

			public enum bool clientbound = false;
			public enum bool serverbound = true;

			public Tuple!(double, "x", double, "y", double, "z") position;
			public float yaw;
			public float pitch;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer.length+=double.sizeof; write!(double, Endian.bigEndian)(buffer, position.x, buffer.length-double.sizeof);buffer.length+=double.sizeof; write!(double, Endian.bigEndian)(buffer, position.y, buffer.length-double.sizeof);buffer.length+=double.sizeof; write!(double, Endian.bigEndian)(buffer, position.z, buffer.length-double.sizeof);
				buffer.length+=float.sizeof; write!(float, Endian.bigEndian)(buffer, yaw, buffer.length-float.sizeof);
				buffer.length+=float.sizeof; write!(float, Endian.bigEndian)(buffer, pitch, buffer.length-float.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				if(buffer.length>=double.sizeof){ position.x=read!(double, Endian.bigEndian)(buffer); }if(buffer.length>=double.sizeof){ position.y=read!(double, Endian.bigEndian)(buffer); }if(buffer.length>=double.sizeof){ position.z=read!(double, Endian.bigEndian)(buffer); }
				if(buffer.length>=float.sizeof){ yaw=read!(float, Endian.bigEndian)(buffer); }
				if(buffer.length>=float.sizeof){ pitch=read!(float, Endian.bigEndian)(buffer); }
				return this;
			}

		}

		static struct EntityAction {

			public enum uint packetId = 20;

			public enum bool clientbound = false;
			public enum bool serverbound = true;

			public uint entityId;
			public uint action;
			public uint jumpBoost;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer~=varuint.encode(entityId);
				buffer~=varuint.encode(action);
				buffer~=varuint.encode(jumpBoost);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				entityId=varuint.fromBuffer(buffer);
				action=varuint.fromBuffer(buffer);
				jumpBoost=varuint.fromBuffer(buffer);
				return this;
			}

		}

		static struct PlayerListHeaderAndFooter {

			public enum uint packetId = 71;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public string header;
			public string footer;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				ubyte[] aGVhZGVy=cast(ubyte[])header; buffer~=varuint.encode(aGVhZGVy.length.to!uint); buffer~=aGVhZGVy;
				ubyte[] Zm9vdGVy=cast(ubyte[])footer; buffer~=varuint.encode(Zm9vdGVy.length.to!uint); buffer~=Zm9vdGVy;
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				ubyte[] aGVhZGVy; aGVhZGVy.length=varuint.fromBuffer(buffer);if(buffer.length>=aGVhZGVy.length){ aGVhZGVy=buffer[0..aGVhZGVy.length]; buffer=buffer[aGVhZGVy.length..$]; }; header=cast(string)aGVhZGVy;
				ubyte[] Zm9vdGVy; Zm9vdGVy.length=varuint.fromBuffer(buffer);if(buffer.length>=Zm9vdGVy.length){ Zm9vdGVy=buffer[0..Zm9vdGVy.length]; buffer=buffer[Zm9vdGVy.length..$]; }; footer=cast(string)Zm9vdGVy;
				return this;
			}

		}

		static struct CloseWindowClientbound {

			public enum uint packetId = 18;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public ubyte window;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, window, buffer.length-ubyte.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				if(buffer.length>=ubyte.sizeof){ window=read!(ubyte, Endian.bigEndian)(buffer); }
				return this;
			}

		}

		static struct WindowProperty {

			public enum uint packetId = 21;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public ubyte window;
			public ushort property;
			public short value;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, window, buffer.length-ubyte.sizeof);
				buffer.length+=ushort.sizeof; write!(ushort, Endian.bigEndian)(buffer, property, buffer.length-ushort.sizeof);
				buffer.length+=short.sizeof; write!(short, Endian.bigEndian)(buffer, value, buffer.length-short.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				if(buffer.length>=ubyte.sizeof){ window=read!(ubyte, Endian.bigEndian)(buffer); }
				if(buffer.length>=ushort.sizeof){ property=read!(ushort, Endian.bigEndian)(buffer); }
				if(buffer.length>=short.sizeof){ value=read!(short, Endian.bigEndian)(buffer); }
				return this;
			}

		}

		static struct Spectate {

			public enum uint packetId = 27;

			public enum bool clientbound = false;
			public enum bool serverbound = true;

			public UUID player;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer~=player.data;
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				if(buffer.length>=16){ ubyte[16] cGxheWVy=buffer[0..16]; buffer=buffer[16..$]; player=UUID(cGxheWVy); }
				return this;
			}

		}

		static struct HeldItemChangeServerbound {

			public enum uint packetId = 23;

			public enum bool clientbound = false;
			public enum bool serverbound = true;

			public ushort slot;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer.length+=ushort.sizeof; write!(ushort, Endian.bigEndian)(buffer, slot, buffer.length-ushort.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				if(buffer.length>=ushort.sizeof){ slot=read!(ushort, Endian.bigEndian)(buffer); }
				return this;
			}

		}

		static struct Title {

			public enum uint packetId = 69;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public uint action;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer~=varuint.encode(action);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				action=varuint.fromBuffer(buffer);
				return this;
			}

			static struct SetSubtitle {

				public enum uint action = 1;
				public string text;

				public ubyte[] encode(bool write_id=true)() {
					ubyte[] buffer;
					static if(write_id){ buffer~=varuint.encode(packetId); }
					buffer~=varuint.encode(action);
					ubyte[] dGV4dA=cast(ubyte[])text; buffer~=varuint.encode(dGV4dA.length.to!uint); buffer~=dGV4dA;
					return buffer;
				}

				public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
					static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
					uint __field_value; if(buffer.length>=uint.sizeof){ __field_value=read!(uint, Endian.bigEndian)(buffer); }
					ubyte[] dGV4dA; dGV4dA.length=varuint.fromBuffer(buffer);if(buffer.length>=dGV4dA.length){ dGV4dA=buffer[0..dGV4dA.length]; buffer=buffer[dGV4dA.length..$]; }; text=cast(string)dGV4dA;
					return this;
				}

			}

			static struct SetTitle {

				public enum uint action = 0;
				public string text;

				public ubyte[] encode(bool write_id=true)() {
					ubyte[] buffer;
					static if(write_id){ buffer~=varuint.encode(packetId); }
					buffer~=varuint.encode(action);
					ubyte[] dGV4dA=cast(ubyte[])text; buffer~=varuint.encode(dGV4dA.length.to!uint); buffer~=dGV4dA;
					return buffer;
				}

				public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
					static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
					uint __field_value; if(buffer.length>=uint.sizeof){ __field_value=read!(uint, Endian.bigEndian)(buffer); }
					ubyte[] dGV4dA; dGV4dA.length=varuint.fromBuffer(buffer);if(buffer.length>=dGV4dA.length){ dGV4dA=buffer[0..dGV4dA.length]; buffer=buffer[dGV4dA.length..$]; }; text=cast(string)dGV4dA;
					return this;
				}

			}

			static struct SetTimings {

				public enum uint action = 3;
				public uint fadeIn;
				public uint stay;
				public uint fadeOut;

				public ubyte[] encode(bool write_id=true)() {
					ubyte[] buffer;
					static if(write_id){ buffer~=varuint.encode(packetId); }
					buffer~=varuint.encode(action);
					buffer.length+=uint.sizeof; write!(uint, Endian.bigEndian)(buffer, fadeIn, buffer.length-uint.sizeof);
					buffer.length+=uint.sizeof; write!(uint, Endian.bigEndian)(buffer, stay, buffer.length-uint.sizeof);
					buffer.length+=uint.sizeof; write!(uint, Endian.bigEndian)(buffer, fadeOut, buffer.length-uint.sizeof);
					return buffer;
				}

				public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
					static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
					uint __field_value; if(buffer.length>=uint.sizeof){ __field_value=read!(uint, Endian.bigEndian)(buffer); }
					if(buffer.length>=uint.sizeof){ fadeIn=read!(uint, Endian.bigEndian)(buffer); }
					if(buffer.length>=uint.sizeof){ stay=read!(uint, Endian.bigEndian)(buffer); }
					if(buffer.length>=uint.sizeof){ fadeOut=read!(uint, Endian.bigEndian)(buffer); }
					return this;
				}

			}

			static struct SetActionBar {

				public enum uint action = 2;
				public string text;

				public ubyte[] encode(bool write_id=true)() {
					ubyte[] buffer;
					static if(write_id){ buffer~=varuint.encode(packetId); }
					buffer~=varuint.encode(action);
					ubyte[] dGV4dA=cast(ubyte[])text; buffer~=varuint.encode(dGV4dA.length.to!uint); buffer~=dGV4dA;
					return buffer;
				}

				public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
					static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
					uint __field_value; if(buffer.length>=uint.sizeof){ __field_value=read!(uint, Endian.bigEndian)(buffer); }
					ubyte[] dGV4dA; dGV4dA.length=varuint.fromBuffer(buffer);if(buffer.length>=dGV4dA.length){ dGV4dA=buffer[0..dGV4dA.length]; buffer=buffer[dGV4dA.length..$]; }; text=cast(string)dGV4dA;
					return this;
				}

			}

			static struct Reset {

				public enum uint action = 5;

				public ubyte[] encode(bool write_id=true)() {
					ubyte[] buffer;
					static if(write_id){ buffer~=varuint.encode(packetId); }
					buffer~=varuint.encode(action);
					return buffer;
				}

				public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
					static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
					uint __field_value; if(buffer.length>=uint.sizeof){ __field_value=read!(uint, Endian.bigEndian)(buffer); }
					return this;
				}

			}

			static struct Hide {

				public enum uint action = 4;

				public ubyte[] encode(bool write_id=true)() {
					ubyte[] buffer;
					static if(write_id){ buffer~=varuint.encode(packetId); }
					buffer~=varuint.encode(action);
					return buffer;
				}

				public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
					static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
					uint __field_value; if(buffer.length>=uint.sizeof){ __field_value=read!(uint, Endian.bigEndian)(buffer); }
					return this;
				}

			}

		}

		static struct CreativeInventoryAction {

			public enum uint packetId = 24;

			public enum bool clientbound = false;
			public enum bool serverbound = true;

			public ushort slot;
			public Types.Slot clickedItem;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer.length+=ushort.sizeof; write!(ushort, Endian.bigEndian)(buffer, slot, buffer.length-ushort.sizeof);
				clickedItem.encode(buffer);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				if(buffer.length>=ushort.sizeof){ slot=read!(ushort, Endian.bigEndian)(buffer); }
				clickedItem.decode(buffer);
				return this;
			}

		}

		static struct UseItem {

			public enum uint packetId = 29;

			public enum bool clientbound = false;
			public enum bool serverbound = true;

			public uint hand;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer~=varuint.encode(hand);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				hand=varuint.fromBuffer(buffer);
				return this;
			}

		}

		static struct UseBed {

			public enum uint packetId = 47;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public uint entityId;
			public ulong position;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer~=varuint.encode(entityId);
				buffer.length+=ulong.sizeof; write!(ulong, Endian.bigEndian)(buffer, position, buffer.length-ulong.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				entityId=varuint.fromBuffer(buffer);
				if(buffer.length>=ulong.sizeof){ position=read!(ulong, Endian.bigEndian)(buffer); }
				return this;
			}

		}

		static struct EnchantItem {

			public enum uint packetId = 6;

			public enum bool clientbound = false;
			public enum bool serverbound = true;

			public ubyte window;
			public ubyte enchantment;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, window, buffer.length-ubyte.sizeof);
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, enchantment, buffer.length-ubyte.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				if(buffer.length>=ubyte.sizeof){ window=read!(ubyte, Endian.bigEndian)(buffer); }
				if(buffer.length>=ubyte.sizeof){ enchantment=read!(ubyte, Endian.bigEndian)(buffer); }
				return this;
			}

		}

		static struct CollectItem {

			public enum uint packetId = 72;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public uint collected;
			public uint collector;
			public uint count;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer~=varuint.encode(collected);
				buffer~=varuint.encode(collector);
				buffer~=varuint.encode(count);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				collected=varuint.fromBuffer(buffer);
				collector=varuint.fromBuffer(buffer);
				count=varuint.fromBuffer(buffer);
				return this;
			}

		}

		static struct SteerBoat {

			public enum uint packetId = 17;

			public enum bool clientbound = false;
			public enum bool serverbound = true;

			public bool rightPaddleTurning;
			public bool leftPaddleTurning;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer.length+=bool.sizeof; write!(bool, Endian.bigEndian)(buffer, rightPaddleTurning, buffer.length-bool.sizeof);
				buffer.length+=bool.sizeof; write!(bool, Endian.bigEndian)(buffer, leftPaddleTurning, buffer.length-bool.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				if(buffer.length>=bool.sizeof){ rightPaddleTurning=read!(bool, Endian.bigEndian)(buffer); }
				if(buffer.length>=bool.sizeof){ leftPaddleTurning=read!(bool, Endian.bigEndian)(buffer); }
				return this;
			}

		}

		static struct ResourcePackStatus {

			public enum uint packetId = 22;

			public enum bool clientbound = false;
			public enum bool serverbound = true;

			public uint result;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer~=varuint.encode(result);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				result=varuint.fromBuffer(buffer);
				return this;
			}

		}

		static struct SpawnGlobalEntity {

			public enum uint packetId = 2;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public uint entityId;
			public ubyte type;
			public Tuple!(double, "x", double, "y", double, "z") position;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer~=varuint.encode(entityId);
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, type, buffer.length-ubyte.sizeof);
				buffer.length+=double.sizeof; write!(double, Endian.bigEndian)(buffer, position.x, buffer.length-double.sizeof);buffer.length+=double.sizeof; write!(double, Endian.bigEndian)(buffer, position.y, buffer.length-double.sizeof);buffer.length+=double.sizeof; write!(double, Endian.bigEndian)(buffer, position.z, buffer.length-double.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				entityId=varuint.fromBuffer(buffer);
				if(buffer.length>=ubyte.sizeof){ type=read!(ubyte, Endian.bigEndian)(buffer); }
				if(buffer.length>=double.sizeof){ position.x=read!(double, Endian.bigEndian)(buffer); }if(buffer.length>=double.sizeof){ position.y=read!(double, Endian.bigEndian)(buffer); }if(buffer.length>=double.sizeof){ position.z=read!(double, Endian.bigEndian)(buffer); }
				return this;
			}

		}

		static struct EntityRelativeMove {

			public enum uint packetId = 37;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public uint entityId;
			public Tuple!(short, "x", short, "y", short, "z") delta;
			public bool onGround;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer~=varuint.encode(entityId);
				buffer.length+=short.sizeof; write!(short, Endian.bigEndian)(buffer, delta.x, buffer.length-short.sizeof);buffer.length+=short.sizeof; write!(short, Endian.bigEndian)(buffer, delta.y, buffer.length-short.sizeof);buffer.length+=short.sizeof; write!(short, Endian.bigEndian)(buffer, delta.z, buffer.length-short.sizeof);
				buffer.length+=bool.sizeof; write!(bool, Endian.bigEndian)(buffer, onGround, buffer.length-bool.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				entityId=varuint.fromBuffer(buffer);
				if(buffer.length>=short.sizeof){ delta.x=read!(short, Endian.bigEndian)(buffer); }if(buffer.length>=short.sizeof){ delta.y=read!(short, Endian.bigEndian)(buffer); }if(buffer.length>=short.sizeof){ delta.z=read!(short, Endian.bigEndian)(buffer); }
				if(buffer.length>=bool.sizeof){ onGround=read!(bool, Endian.bigEndian)(buffer); }
				return this;
			}

		}

		static struct ResourcePackSend {

			public enum uint packetId = 50;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public string url;
			public string hash;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				ubyte[] dXJs=cast(ubyte[])url; buffer~=varuint.encode(dXJs.length.to!uint); buffer~=dXJs;
				ubyte[] aGFzaA=cast(ubyte[])hash; buffer~=varuint.encode(aGFzaA.length.to!uint); buffer~=aGFzaA;
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				ubyte[] dXJs; dXJs.length=varuint.fromBuffer(buffer);if(buffer.length>=dXJs.length){ dXJs=buffer[0..dXJs.length]; buffer=buffer[dXJs.length..$]; }; url=cast(string)dXJs;
				ubyte[] aGFzaA; aGFzaA.length=varuint.fromBuffer(buffer);if(buffer.length>=aGFzaA.length){ aGFzaA=buffer[0..aGFzaA.length]; buffer=buffer[aGFzaA.length..$]; }; hash=cast(string)aGFzaA;
				return this;
			}

		}

		static struct PlayerAbilities {

			public enum uint packetId = 43;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public ubyte flags;
			public float flyingSpeed;
			public float fovModifier;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, flags, buffer.length-ubyte.sizeof);
				buffer.length+=float.sizeof; write!(float, Endian.bigEndian)(buffer, flyingSpeed, buffer.length-float.sizeof);
				buffer.length+=float.sizeof; write!(float, Endian.bigEndian)(buffer, fovModifier, buffer.length-float.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				if(buffer.length>=ubyte.sizeof){ flags=read!(ubyte, Endian.bigEndian)(buffer); }
				if(buffer.length>=float.sizeof){ flyingSpeed=read!(float, Endian.bigEndian)(buffer); }
				if(buffer.length>=float.sizeof){ fovModifier=read!(float, Endian.bigEndian)(buffer); }
				return this;
			}

		}

		static struct SoundEffect {

			public enum uint packetId = 70;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public uint id;
			public uint category;
			public Tuple!(int, "x", int, "y", int, "z") position;
			public float volume;
			public float pitch;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer~=varuint.encode(id);
				buffer~=varuint.encode(category);
				buffer.length+=int.sizeof; write!(int, Endian.bigEndian)(buffer, position.x, buffer.length-int.sizeof);buffer.length+=int.sizeof; write!(int, Endian.bigEndian)(buffer, position.y, buffer.length-int.sizeof);buffer.length+=int.sizeof; write!(int, Endian.bigEndian)(buffer, position.z, buffer.length-int.sizeof);
				buffer.length+=float.sizeof; write!(float, Endian.bigEndian)(buffer, volume, buffer.length-float.sizeof);
				buffer.length+=float.sizeof; write!(float, Endian.bigEndian)(buffer, pitch, buffer.length-float.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				id=varuint.fromBuffer(buffer);
				category=varuint.fromBuffer(buffer);
				if(buffer.length>=int.sizeof){ position.x=read!(int, Endian.bigEndian)(buffer); }if(buffer.length>=int.sizeof){ position.y=read!(int, Endian.bigEndian)(buffer); }if(buffer.length>=int.sizeof){ position.z=read!(int, Endian.bigEndian)(buffer); }
				if(buffer.length>=float.sizeof){ volume=read!(float, Endian.bigEndian)(buffer); }
				if(buffer.length>=float.sizeof){ pitch=read!(float, Endian.bigEndian)(buffer); }
				return this;
			}

		}

		static struct Disconnect {

			public enum uint packetId = 26;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public string reason;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				ubyte[] cmVhc29u=cast(ubyte[])reason; buffer~=varuint.encode(cmVhc29u.length.to!uint); buffer~=cmVhc29u;
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				ubyte[] cmVhc29u; cmVhc29u.length=varuint.fromBuffer(buffer);if(buffer.length>=cmVhc29u.length){ cmVhc29u=buffer[0..cmVhc29u.length]; buffer=buffer[cmVhc29u.length..$]; }; reason=cast(string)cmVhc29u;
				return this;
			}

		}

		static struct EntityProperties {

			public enum uint packetId = 74;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public uint entityId;
			public Types.Property[] properties;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer~=varuint.encode(entityId);
				buffer.length+=uint.sizeof; write!(uint, Endian.bigEndian)(buffer, properties.length.to!uint, buffer.length-uint.sizeof);foreach(cHJvcGVydGllcw;properties){ cHJvcGVydGllcw.encode(buffer); }
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				entityId=varuint.fromBuffer(buffer);
				if(buffer.length>=uint.sizeof){ properties.length=read!(uint, Endian.bigEndian)(buffer); }foreach(ref cHJvcGVydGllcw;properties){ cHJvcGVydGllcw.decode(buffer);}
				return this;
			}

		}

		static struct AnimationClientbound {

			public enum uint packetId = 6;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public uint entityId;
			public ubyte animation;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer~=varuint.encode(entityId);
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, animation, buffer.length-ubyte.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				entityId=varuint.fromBuffer(buffer);
				if(buffer.length>=ubyte.sizeof){ animation=read!(ubyte, Endian.bigEndian)(buffer); }
				return this;
			}

		}

		static struct EntityVelocity {

			public enum uint packetId = 59;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public uint entityId;
			public Tuple!(short, "x", short, "y", short, "z") velocity;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer~=varuint.encode(entityId);
				buffer.length+=short.sizeof; write!(short, Endian.bigEndian)(buffer, velocity.x, buffer.length-short.sizeof);buffer.length+=short.sizeof; write!(short, Endian.bigEndian)(buffer, velocity.y, buffer.length-short.sizeof);buffer.length+=short.sizeof; write!(short, Endian.bigEndian)(buffer, velocity.z, buffer.length-short.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				entityId=varuint.fromBuffer(buffer);
				if(buffer.length>=short.sizeof){ velocity.x=read!(short, Endian.bigEndian)(buffer); }if(buffer.length>=short.sizeof){ velocity.y=read!(short, Endian.bigEndian)(buffer); }if(buffer.length>=short.sizeof){ velocity.z=read!(short, Endian.bigEndian)(buffer); }
				return this;
			}

		}

		static struct CombatEvent {

			public enum uint packetId = 44;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public ubyte event;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, event, buffer.length-ubyte.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				if(buffer.length>=ubyte.sizeof){ event=read!(ubyte, Endian.bigEndian)(buffer); }
				return this;
			}

			static struct EnterCombat {

				public enum ubyte event = 0;

				public ubyte[] encode(bool write_id=true)() {
					ubyte[] buffer;
					static if(write_id){ buffer~=varuint.encode(packetId); }
					buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, event, buffer.length-ubyte.sizeof);
					return buffer;
				}

				public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
					static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
					ubyte __field_value; if(buffer.length>=ubyte.sizeof){ __field_value=read!(ubyte, Endian.bigEndian)(buffer); }
					return this;
				}

			}

			static struct EndCombat {

				public enum ubyte event = 1;
				public uint duration;
				public uint entityId;

				public ubyte[] encode(bool write_id=true)() {
					ubyte[] buffer;
					static if(write_id){ buffer~=varuint.encode(packetId); }
					buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, event, buffer.length-ubyte.sizeof);
					buffer~=varuint.encode(duration);
					buffer.length+=uint.sizeof; write!(uint, Endian.bigEndian)(buffer, entityId, buffer.length-uint.sizeof);
					return buffer;
				}

				public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
					static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
					ubyte __field_value; if(buffer.length>=ubyte.sizeof){ __field_value=read!(ubyte, Endian.bigEndian)(buffer); }
					duration=varuint.fromBuffer(buffer);
					if(buffer.length>=uint.sizeof){ entityId=read!(uint, Endian.bigEndian)(buffer); }
					return this;
				}

			}

			static struct EntityDead {

				public enum ubyte event = 2;
				public uint playerId;
				public uint entityId;
				public string message;

				public ubyte[] encode(bool write_id=true)() {
					ubyte[] buffer;
					static if(write_id){ buffer~=varuint.encode(packetId); }
					buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, event, buffer.length-ubyte.sizeof);
					buffer~=varuint.encode(playerId);
					buffer.length+=uint.sizeof; write!(uint, Endian.bigEndian)(buffer, entityId, buffer.length-uint.sizeof);
					ubyte[] bWVzc2FnZQ=cast(ubyte[])message; buffer~=varuint.encode(bWVzc2FnZQ.length.to!uint); buffer~=bWVzc2FnZQ;
					return buffer;
				}

				public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
					static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
					ubyte __field_value; if(buffer.length>=ubyte.sizeof){ __field_value=read!(ubyte, Endian.bigEndian)(buffer); }
					playerId=varuint.fromBuffer(buffer);
					if(buffer.length>=uint.sizeof){ entityId=read!(uint, Endian.bigEndian)(buffer); }
					ubyte[] bWVzc2FnZQ; bWVzc2FnZQ.length=varuint.fromBuffer(buffer);if(buffer.length>=bWVzc2FnZQ.length){ bWVzc2FnZQ=buffer[0..bWVzc2FnZQ.length]; buffer=buffer[bWVzc2FnZQ.length..$]; }; message=cast(string)bWVzc2FnZQ;
					return this;
				}

			}

		}

		static struct BlockChange {

			public enum uint packetId = 11;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public ulong position;
			public uint block;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer.length+=ulong.sizeof; write!(ulong, Endian.bigEndian)(buffer, position, buffer.length-ulong.sizeof);
				buffer~=varuint.encode(block);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				if(buffer.length>=ulong.sizeof){ position=read!(ulong, Endian.bigEndian)(buffer); }
				block=varuint.fromBuffer(buffer);
				return this;
			}

		}

		static struct SpawnPainting {

			public enum uint packetId = 4;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public uint entityId;
			public UUID uuid;
			public string title;
			public ulong position;
			public ubyte direction;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer~=varuint.encode(entityId);
				buffer~=uuid.data;
				ubyte[] dGl0bGU=cast(ubyte[])title; buffer~=varuint.encode(dGl0bGU.length.to!uint); buffer~=dGl0bGU;
				buffer.length+=ulong.sizeof; write!(ulong, Endian.bigEndian)(buffer, position, buffer.length-ulong.sizeof);
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, direction, buffer.length-ubyte.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				entityId=varuint.fromBuffer(buffer);
				if(buffer.length>=16){ ubyte[16] dXVpZA=buffer[0..16]; buffer=buffer[16..$]; uuid=UUID(dXVpZA); }
				ubyte[] dGl0bGU; dGl0bGU.length=varuint.fromBuffer(buffer);if(buffer.length>=dGl0bGU.length){ dGl0bGU=buffer[0..dGl0bGU.length]; buffer=buffer[dGl0bGU.length..$]; }; title=cast(string)dGl0bGU;
				if(buffer.length>=ulong.sizeof){ position=read!(ulong, Endian.bigEndian)(buffer); }
				if(buffer.length>=ubyte.sizeof){ direction=read!(ubyte, Endian.bigEndian)(buffer); }
				return this;
			}

		}

		static struct BlockAction {

			public enum uint packetId = 10;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public ulong position;
			public ubyte[2] actions;
			public uint blockType;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer.length+=ulong.sizeof; write!(ulong, Endian.bigEndian)(buffer, position, buffer.length-ulong.sizeof);
				 buffer~=actions;
				buffer~=varuint.encode(blockType);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				if(buffer.length>=ulong.sizeof){ position=read!(ulong, Endian.bigEndian)(buffer); }
				if(buffer.length>=actions.length){ actions=buffer[0..actions.length]; buffer=buffer[actions.length..$]; }
				blockType=varuint.fromBuffer(buffer);
				return this;
			}

		}

		static struct Respawn {

			public enum uint packetId = 51;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public int dimension;
			public ubyte difficulty;
			public ubyte gamemode;
			public string levelType;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer.length+=int.sizeof; write!(int, Endian.bigEndian)(buffer, dimension, buffer.length-int.sizeof);
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, difficulty, buffer.length-ubyte.sizeof);
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, gamemode, buffer.length-ubyte.sizeof);
				ubyte[] bGV2ZWxUeXBl=cast(ubyte[])levelType; buffer~=varuint.encode(bGV2ZWxUeXBl.length.to!uint); buffer~=bGV2ZWxUeXBl;
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				if(buffer.length>=int.sizeof){ dimension=read!(int, Endian.bigEndian)(buffer); }
				if(buffer.length>=ubyte.sizeof){ difficulty=read!(ubyte, Endian.bigEndian)(buffer); }
				if(buffer.length>=ubyte.sizeof){ gamemode=read!(ubyte, Endian.bigEndian)(buffer); }
				ubyte[] bGV2ZWxUeXBl; bGV2ZWxUeXBl.length=varuint.fromBuffer(buffer);if(buffer.length>=bGV2ZWxUeXBl.length){ bGV2ZWxUeXBl=buffer[0..bGV2ZWxUeXBl.length]; buffer=buffer[bGV2ZWxUeXBl.length..$]; }; levelType=cast(string)bGV2ZWxUeXBl;
				return this;
			}

		}

		static struct Statistics {

			public enum uint packetId = 7;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public Types.Statistic[] statistics;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer~=varuint.encode(statistics.length.to!uint);foreach(c3RhdGlzdGljcw;statistics){ c3RhdGlzdGljcw.encode(buffer); }
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				statistics.length=varuint.fromBuffer(buffer);foreach(ref c3RhdGlzdGljcw;statistics){ c3RhdGlzdGljcw.decode(buffer);}
				return this;
			}

		}

		static struct MultiBlockChange {

			public enum uint packetId = 16;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public Tuple!(int, "x", int, "z") chunk;
			public Types.BlockChange[] changes;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer.length+=int.sizeof; write!(int, Endian.bigEndian)(buffer, chunk.x, buffer.length-int.sizeof);buffer.length+=int.sizeof; write!(int, Endian.bigEndian)(buffer, chunk.z, buffer.length-int.sizeof);
				buffer~=varuint.encode(changes.length.to!uint);foreach(Y2hhbmdlcw;changes){ Y2hhbmdlcw.encode(buffer); }
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				if(buffer.length>=int.sizeof){ chunk.x=read!(int, Endian.bigEndian)(buffer); }if(buffer.length>=int.sizeof){ chunk.z=read!(int, Endian.bigEndian)(buffer); }
				changes.length=varuint.fromBuffer(buffer);foreach(ref Y2hhbmdlcw;changes){ Y2hhbmdlcw.decode(buffer);}
				return this;
			}

		}

		static struct OpenWindow {

			public enum uint packetId = 19;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public ubyte window;
			public string type;
			public string title;
			public ubyte slots;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, window, buffer.length-ubyte.sizeof);
				ubyte[] dHlwZQ=cast(ubyte[])type; buffer~=varuint.encode(dHlwZQ.length.to!uint); buffer~=dHlwZQ;
				ubyte[] dGl0bGU=cast(ubyte[])title; buffer~=varuint.encode(dGl0bGU.length.to!uint); buffer~=dGl0bGU;
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, slots, buffer.length-ubyte.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				if(buffer.length>=ubyte.sizeof){ window=read!(ubyte, Endian.bigEndian)(buffer); }
				ubyte[] dHlwZQ; dHlwZQ.length=varuint.fromBuffer(buffer);if(buffer.length>=dHlwZQ.length){ dHlwZQ=buffer[0..dHlwZQ.length]; buffer=buffer[dHlwZQ.length..$]; }; type=cast(string)dHlwZQ;
				ubyte[] dGl0bGU; dGl0bGU.length=varuint.fromBuffer(buffer);if(buffer.length>=dGl0bGU.length){ dGl0bGU=buffer[0..dGl0bGU.length]; buffer=buffer[dGl0bGU.length..$]; }; title=cast(string)dGl0bGU;
				if(buffer.length>=ubyte.sizeof){ slots=read!(ubyte, Endian.bigEndian)(buffer); }
				return this;
			}

		}

		static struct RemoveEntityEffect {

			public enum uint packetId = 49;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public uint entityId;
			public ubyte effect;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer~=varuint.encode(entityId);
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, effect, buffer.length-ubyte.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				entityId=varuint.fromBuffer(buffer);
				if(buffer.length>=ubyte.sizeof){ effect=read!(ubyte, Endian.bigEndian)(buffer); }
				return this;
			}

		}

		static struct HeldItemChangeClientbound {

			public enum uint packetId = 55;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public ubyte slot;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, slot, buffer.length-ubyte.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				if(buffer.length>=ubyte.sizeof){ slot=read!(ubyte, Endian.bigEndian)(buffer); }
				return this;
			}

		}

		static struct AttachEntity {

			public enum uint packetId = 58;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public uint target;
			public uint holder;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer.length+=uint.sizeof; write!(uint, Endian.bigEndian)(buffer, target, buffer.length-uint.sizeof);
				buffer.length+=uint.sizeof; write!(uint, Endian.bigEndian)(buffer, holder, buffer.length-uint.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				if(buffer.length>=uint.sizeof){ target=read!(uint, Endian.bigEndian)(buffer); }
				if(buffer.length>=uint.sizeof){ holder=read!(uint, Endian.bigEndian)(buffer); }
				return this;
			}

		}

		static struct ChangeGameState {

			public enum uint packetId = 30;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public ubyte reason;
			public float value;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, reason, buffer.length-ubyte.sizeof);
				buffer.length+=float.sizeof; write!(float, Endian.bigEndian)(buffer, value, buffer.length-float.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				if(buffer.length>=ubyte.sizeof){ reason=read!(ubyte, Endian.bigEndian)(buffer); }
				if(buffer.length>=float.sizeof){ value=read!(float, Endian.bigEndian)(buffer); }
				return this;
			}

		}

		static struct SpawnObject {

			public enum uint packetId = 0;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public uint entityId;
			public UUID uuid;
			public ubyte type;
			public Tuple!(double, "x", double, "y", double, "z") position;
			public ubyte pitch;
			public ubyte yaw;
			public int data;
			public Tuple!(short, "x", short, "y", short, "z") velocity;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer~=varuint.encode(entityId);
				buffer~=uuid.data;
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, type, buffer.length-ubyte.sizeof);
				buffer.length+=double.sizeof; write!(double, Endian.bigEndian)(buffer, position.x, buffer.length-double.sizeof);buffer.length+=double.sizeof; write!(double, Endian.bigEndian)(buffer, position.y, buffer.length-double.sizeof);buffer.length+=double.sizeof; write!(double, Endian.bigEndian)(buffer, position.z, buffer.length-double.sizeof);
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, pitch, buffer.length-ubyte.sizeof);
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, yaw, buffer.length-ubyte.sizeof);
				buffer.length+=int.sizeof; write!(int, Endian.bigEndian)(buffer, data, buffer.length-int.sizeof);
				buffer.length+=short.sizeof; write!(short, Endian.bigEndian)(buffer, velocity.x, buffer.length-short.sizeof);buffer.length+=short.sizeof; write!(short, Endian.bigEndian)(buffer, velocity.y, buffer.length-short.sizeof);buffer.length+=short.sizeof; write!(short, Endian.bigEndian)(buffer, velocity.z, buffer.length-short.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				entityId=varuint.fromBuffer(buffer);
				if(buffer.length>=16){ ubyte[16] dXVpZA=buffer[0..16]; buffer=buffer[16..$]; uuid=UUID(dXVpZA); }
				if(buffer.length>=ubyte.sizeof){ type=read!(ubyte, Endian.bigEndian)(buffer); }
				if(buffer.length>=double.sizeof){ position.x=read!(double, Endian.bigEndian)(buffer); }if(buffer.length>=double.sizeof){ position.y=read!(double, Endian.bigEndian)(buffer); }if(buffer.length>=double.sizeof){ position.z=read!(double, Endian.bigEndian)(buffer); }
				if(buffer.length>=ubyte.sizeof){ pitch=read!(ubyte, Endian.bigEndian)(buffer); }
				if(buffer.length>=ubyte.sizeof){ yaw=read!(ubyte, Endian.bigEndian)(buffer); }
				if(buffer.length>=int.sizeof){ data=read!(int, Endian.bigEndian)(buffer); }
				if(buffer.length>=short.sizeof){ velocity.x=read!(short, Endian.bigEndian)(buffer); }if(buffer.length>=short.sizeof){ velocity.y=read!(short, Endian.bigEndian)(buffer); }if(buffer.length>=short.sizeof){ velocity.z=read!(short, Endian.bigEndian)(buffer); }
				return this;
			}

		}

		static struct ServerDifficulty {

			public enum uint packetId = 13;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public ubyte difficulty;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, difficulty, buffer.length-ubyte.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				if(buffer.length>=ubyte.sizeof){ difficulty=read!(ubyte, Endian.bigEndian)(buffer); }
				return this;
			}

		}

		static struct Particle {

			public enum uint packetId = 34;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public uint id;
			public bool longDistance;
			public Tuple!(float, "x", float, "y", float, "z") position;
			public Tuple!(float, "x", float, "y", float, "z") offset;
			public float data;
			public uint count;
			public uint[2] additionalData;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer.length+=uint.sizeof; write!(uint, Endian.bigEndian)(buffer, id, buffer.length-uint.sizeof);
				buffer.length+=bool.sizeof; write!(bool, Endian.bigEndian)(buffer, longDistance, buffer.length-bool.sizeof);
				buffer.length+=float.sizeof; write!(float, Endian.bigEndian)(buffer, position.x, buffer.length-float.sizeof);buffer.length+=float.sizeof; write!(float, Endian.bigEndian)(buffer, position.y, buffer.length-float.sizeof);buffer.length+=float.sizeof; write!(float, Endian.bigEndian)(buffer, position.z, buffer.length-float.sizeof);
				buffer.length+=float.sizeof; write!(float, Endian.bigEndian)(buffer, offset.x, buffer.length-float.sizeof);buffer.length+=float.sizeof; write!(float, Endian.bigEndian)(buffer, offset.y, buffer.length-float.sizeof);buffer.length+=float.sizeof; write!(float, Endian.bigEndian)(buffer, offset.z, buffer.length-float.sizeof);
				buffer.length+=float.sizeof; write!(float, Endian.bigEndian)(buffer, data, buffer.length-float.sizeof);
				buffer.length+=uint.sizeof; write!(uint, Endian.bigEndian)(buffer, count, buffer.length-uint.sizeof);
				foreach(YWRkaXRpb25hbERh;additionalData){ buffer~=varuint.encode(YWRkaXRpb25hbERh); }
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				if(buffer.length>=uint.sizeof){ id=read!(uint, Endian.bigEndian)(buffer); }
				if(buffer.length>=bool.sizeof){ longDistance=read!(bool, Endian.bigEndian)(buffer); }
				if(buffer.length>=float.sizeof){ position.x=read!(float, Endian.bigEndian)(buffer); }if(buffer.length>=float.sizeof){ position.y=read!(float, Endian.bigEndian)(buffer); }if(buffer.length>=float.sizeof){ position.z=read!(float, Endian.bigEndian)(buffer); }
				if(buffer.length>=float.sizeof){ offset.x=read!(float, Endian.bigEndian)(buffer); }if(buffer.length>=float.sizeof){ offset.y=read!(float, Endian.bigEndian)(buffer); }if(buffer.length>=float.sizeof){ offset.z=read!(float, Endian.bigEndian)(buffer); }
				if(buffer.length>=float.sizeof){ data=read!(float, Endian.bigEndian)(buffer); }
				if(buffer.length>=uint.sizeof){ count=read!(uint, Endian.bigEndian)(buffer); }
				foreach(ref YWRkaXRpb25hbERh;additionalData){ YWRkaXRpb25hbERh=varuint.fromBuffer(buffer);}
				return this;
			}

		}

		static struct BlockBreakAnimation {

			public enum uint packetId = 8;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public uint entityId;
			public ulong position;
			public ubyte stage;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer~=varuint.encode(entityId);
				buffer.length+=ulong.sizeof; write!(ulong, Endian.bigEndian)(buffer, position, buffer.length-ulong.sizeof);
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, stage, buffer.length-ubyte.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				entityId=varuint.fromBuffer(buffer);
				if(buffer.length>=ulong.sizeof){ position=read!(ulong, Endian.bigEndian)(buffer); }
				if(buffer.length>=ubyte.sizeof){ stage=read!(ubyte, Endian.bigEndian)(buffer); }
				return this;
			}

		}

		static struct SpawnPosition {

			public enum uint packetId = 67;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public ulong position;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer.length+=ulong.sizeof; write!(ulong, Endian.bigEndian)(buffer, position, buffer.length-ulong.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				if(buffer.length>=ulong.sizeof){ position=read!(ulong, Endian.bigEndian)(buffer); }
				return this;
			}

		}

		static struct VehicleMoveClientbound {

			public enum uint packetId = 41;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public Tuple!(double, "x", double, "y", double, "z") position;
			public float yaw;
			public float pitch;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer.length+=double.sizeof; write!(double, Endian.bigEndian)(buffer, position.x, buffer.length-double.sizeof);buffer.length+=double.sizeof; write!(double, Endian.bigEndian)(buffer, position.y, buffer.length-double.sizeof);buffer.length+=double.sizeof; write!(double, Endian.bigEndian)(buffer, position.z, buffer.length-double.sizeof);
				buffer.length+=float.sizeof; write!(float, Endian.bigEndian)(buffer, yaw, buffer.length-float.sizeof);
				buffer.length+=float.sizeof; write!(float, Endian.bigEndian)(buffer, pitch, buffer.length-float.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				if(buffer.length>=double.sizeof){ position.x=read!(double, Endian.bigEndian)(buffer); }if(buffer.length>=double.sizeof){ position.y=read!(double, Endian.bigEndian)(buffer); }if(buffer.length>=double.sizeof){ position.z=read!(double, Endian.bigEndian)(buffer); }
				if(buffer.length>=float.sizeof){ yaw=read!(float, Endian.bigEndian)(buffer); }
				if(buffer.length>=float.sizeof){ pitch=read!(float, Endian.bigEndian)(buffer); }
				return this;
			}

		}

		static struct ClientSettings {

			public enum uint packetId = 4;

			public enum bool clientbound = false;
			public enum bool serverbound = true;

			public string language;
			public ubyte viewDistance;
			public uint chatMode;
			public bool chatColors;
			public ubyte displayedSkinParts;
			public uint mainHand;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				ubyte[] bGFuZ3VhZ2U=cast(ubyte[])language; buffer~=varuint.encode(bGFuZ3VhZ2U.length.to!uint); buffer~=bGFuZ3VhZ2U;
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, viewDistance, buffer.length-ubyte.sizeof);
				buffer~=varuint.encode(chatMode);
				buffer.length+=bool.sizeof; write!(bool, Endian.bigEndian)(buffer, chatColors, buffer.length-bool.sizeof);
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, displayedSkinParts, buffer.length-ubyte.sizeof);
				buffer~=varuint.encode(mainHand);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				ubyte[] bGFuZ3VhZ2U; bGFuZ3VhZ2U.length=varuint.fromBuffer(buffer);if(buffer.length>=bGFuZ3VhZ2U.length){ bGFuZ3VhZ2U=buffer[0..bGFuZ3VhZ2U.length]; buffer=buffer[bGFuZ3VhZ2U.length..$]; }; language=cast(string)bGFuZ3VhZ2U;
				if(buffer.length>=ubyte.sizeof){ viewDistance=read!(ubyte, Endian.bigEndian)(buffer); }
				chatMode=varuint.fromBuffer(buffer);
				if(buffer.length>=bool.sizeof){ chatColors=read!(bool, Endian.bigEndian)(buffer); }
				if(buffer.length>=ubyte.sizeof){ displayedSkinParts=read!(ubyte, Endian.bigEndian)(buffer); }
				mainHand=varuint.fromBuffer(buffer);
				return this;
			}

		}

		static struct PlayerPositionAndLookServerbound {

			public enum uint packetId = 13;

			public enum bool clientbound = false;
			public enum bool serverbound = true;

			public Tuple!(double, "x", double, "y", double, "z") position;
			public float yaw;
			public float pitch;
			public bool onGround;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer.length+=double.sizeof; write!(double, Endian.bigEndian)(buffer, position.x, buffer.length-double.sizeof);buffer.length+=double.sizeof; write!(double, Endian.bigEndian)(buffer, position.y, buffer.length-double.sizeof);buffer.length+=double.sizeof; write!(double, Endian.bigEndian)(buffer, position.z, buffer.length-double.sizeof);
				buffer.length+=float.sizeof; write!(float, Endian.bigEndian)(buffer, yaw, buffer.length-float.sizeof);
				buffer.length+=float.sizeof; write!(float, Endian.bigEndian)(buffer, pitch, buffer.length-float.sizeof);
				buffer.length+=bool.sizeof; write!(bool, Endian.bigEndian)(buffer, onGround, buffer.length-bool.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				if(buffer.length>=double.sizeof){ position.x=read!(double, Endian.bigEndian)(buffer); }if(buffer.length>=double.sizeof){ position.y=read!(double, Endian.bigEndian)(buffer); }if(buffer.length>=double.sizeof){ position.z=read!(double, Endian.bigEndian)(buffer); }
				if(buffer.length>=float.sizeof){ yaw=read!(float, Endian.bigEndian)(buffer); }
				if(buffer.length>=float.sizeof){ pitch=read!(float, Endian.bigEndian)(buffer); }
				if(buffer.length>=bool.sizeof){ onGround=read!(bool, Endian.bigEndian)(buffer); }
				return this;
			}

		}

		static struct Effect {

			public enum uint packetId = 33;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public uint id;
			public ulong position;
			public uint data;
			public bool disableVolume;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer.length+=uint.sizeof; write!(uint, Endian.bigEndian)(buffer, id, buffer.length-uint.sizeof);
				buffer.length+=ulong.sizeof; write!(ulong, Endian.bigEndian)(buffer, position, buffer.length-ulong.sizeof);
				buffer.length+=uint.sizeof; write!(uint, Endian.bigEndian)(buffer, data, buffer.length-uint.sizeof);
				buffer.length+=bool.sizeof; write!(bool, Endian.bigEndian)(buffer, disableVolume, buffer.length-bool.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				if(buffer.length>=uint.sizeof){ id=read!(uint, Endian.bigEndian)(buffer); }
				if(buffer.length>=ulong.sizeof){ position=read!(ulong, Endian.bigEndian)(buffer); }
				if(buffer.length>=uint.sizeof){ data=read!(uint, Endian.bigEndian)(buffer); }
				if(buffer.length>=bool.sizeof){ disableVolume=read!(bool, Endian.bigEndian)(buffer); }
				return this;
			}

		}

		static struct PlayerListItem {

			public enum uint packetId = 45;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public uint action;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer~=varuint.encode(action);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				action=varuint.fromBuffer(buffer);
				return this;
			}

			static struct UpdateLatency {

				public enum uint action = 2;
				public Types.ListUpdateLatency[] players;

				public ubyte[] encode(bool write_id=true)() {
					ubyte[] buffer;
					static if(write_id){ buffer~=varuint.encode(packetId); }
					buffer~=varuint.encode(action);
					buffer~=varuint.encode(players.length.to!uint);foreach(cGxheWVycw;players){ cGxheWVycw.encode(buffer); }
					return buffer;
				}

				public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
					static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
					uint __field_value; if(buffer.length>=uint.sizeof){ __field_value=read!(uint, Endian.bigEndian)(buffer); }
					players.length=varuint.fromBuffer(buffer);foreach(ref cGxheWVycw;players){ cGxheWVycw.decode(buffer);}
					return this;
				}

			}

			static struct RemovePlayer {

				public enum uint action = 4;
				public UUID[] players;

				public ubyte[] encode(bool write_id=true)() {
					ubyte[] buffer;
					static if(write_id){ buffer~=varuint.encode(packetId); }
					buffer~=varuint.encode(action);
					buffer~=varuint.encode(players.length.to!uint);foreach(cGxheWVycw;players){ buffer~=cGxheWVycw.data; }
					return buffer;
				}

				public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
					static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
					uint __field_value; if(buffer.length>=uint.sizeof){ __field_value=read!(uint, Endian.bigEndian)(buffer); }
					players.length=varuint.fromBuffer(buffer);foreach(ref cGxheWVycw;players){ if(buffer.length>=16){ ubyte[16] Y0d4aGVXVnljdw=buffer[0..16]; buffer=buffer[16..$]; cGxheWVycw=UUID(Y0d4aGVXVnljdw); }}
					return this;
				}

			}

			static struct UpdateDisplayName {

				public enum uint action = 3;
				public Types.ListUpdateDisplayName[] players;

				public ubyte[] encode(bool write_id=true)() {
					ubyte[] buffer;
					static if(write_id){ buffer~=varuint.encode(packetId); }
					buffer~=varuint.encode(action);
					buffer~=varuint.encode(players.length.to!uint);foreach(cGxheWVycw;players){ cGxheWVycw.encode(buffer); }
					return buffer;
				}

				public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
					static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
					uint __field_value; if(buffer.length>=uint.sizeof){ __field_value=read!(uint, Endian.bigEndian)(buffer); }
					players.length=varuint.fromBuffer(buffer);foreach(ref cGxheWVycw;players){ cGxheWVycw.decode(buffer);}
					return this;
				}

			}

			static struct AddPlayer {

				public enum uint action = 0;
				public Types.ListAddPlayer[] players;

				public ubyte[] encode(bool write_id=true)() {
					ubyte[] buffer;
					static if(write_id){ buffer~=varuint.encode(packetId); }
					buffer~=varuint.encode(action);
					buffer~=varuint.encode(players.length.to!uint);foreach(cGxheWVycw;players){ cGxheWVycw.encode(buffer); }
					return buffer;
				}

				public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
					static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
					uint __field_value; if(buffer.length>=uint.sizeof){ __field_value=read!(uint, Endian.bigEndian)(buffer); }
					players.length=varuint.fromBuffer(buffer);foreach(ref cGxheWVycw;players){ cGxheWVycw.decode(buffer);}
					return this;
				}

			}

			static struct UpdateGamemode {

				public enum uint action = 1;
				public Types.ListUpdateGamemode[] players;

				public ubyte[] encode(bool write_id=true)() {
					ubyte[] buffer;
					static if(write_id){ buffer~=varuint.encode(packetId); }
					buffer~=varuint.encode(action);
					buffer~=varuint.encode(players.length.to!uint);foreach(cGxheWVycw;players){ cGxheWVycw.encode(buffer); }
					return buffer;
				}

				public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
					static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
					uint __field_value; if(buffer.length>=uint.sizeof){ __field_value=read!(uint, Endian.bigEndian)(buffer); }
					players.length=varuint.fromBuffer(buffer);foreach(ref cGxheWVycw;players){ cGxheWVycw.decode(buffer);}
					return this;
				}

			}

		}

		static struct PlayerLook {

			public enum uint packetId = 14;

			public enum bool clientbound = false;
			public enum bool serverbound = true;

			public float yaw;
			public float pitch;
			public bool onGround;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer.length+=float.sizeof; write!(float, Endian.bigEndian)(buffer, yaw, buffer.length-float.sizeof);
				buffer.length+=float.sizeof; write!(float, Endian.bigEndian)(buffer, pitch, buffer.length-float.sizeof);
				buffer.length+=bool.sizeof; write!(bool, Endian.bigEndian)(buffer, onGround, buffer.length-bool.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				if(buffer.length>=float.sizeof){ yaw=read!(float, Endian.bigEndian)(buffer); }
				if(buffer.length>=float.sizeof){ pitch=read!(float, Endian.bigEndian)(buffer); }
				if(buffer.length>=bool.sizeof){ onGround=read!(bool, Endian.bigEndian)(buffer); }
				return this;
			}

		}

		static struct PluginMessageClientbound {

			public enum uint packetId = 24;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public string channel;
			public ubyte[] data;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				ubyte[] Y2hhbm5lbA=cast(ubyte[])channel; buffer~=varuint.encode(Y2hhbm5lbA.length.to!uint); buffer~=Y2hhbm5lbA;
				buffer~=data;
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				ubyte[] Y2hhbm5lbA; Y2hhbm5lbA.length=varuint.fromBuffer(buffer);if(buffer.length>=Y2hhbm5lbA.length){ Y2hhbm5lbA=buffer[0..Y2hhbm5lbA.length]; buffer=buffer[Y2hhbm5lbA.length..$]; }; channel=cast(string)Y2hhbm5lbA;
				data=buffer.dup; buffer.length=0;
				return this;
			}

		}

		static struct SteerVehicle {

			public enum uint packetId = 21;

			public enum bool clientbound = false;
			public enum bool serverbound = true;

			public float sideways;
			public float forward;
			public ubyte flags;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer.length+=float.sizeof; write!(float, Endian.bigEndian)(buffer, sideways, buffer.length-float.sizeof);
				buffer.length+=float.sizeof; write!(float, Endian.bigEndian)(buffer, forward, buffer.length-float.sizeof);
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, flags, buffer.length-ubyte.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				if(buffer.length>=float.sizeof){ sideways=read!(float, Endian.bigEndian)(buffer); }
				if(buffer.length>=float.sizeof){ forward=read!(float, Endian.bigEndian)(buffer); }
				if(buffer.length>=ubyte.sizeof){ flags=read!(ubyte, Endian.bigEndian)(buffer); }
				return this;
			}

		}

		static struct Player {

			public enum uint packetId = 15;

			public enum bool clientbound = false;
			public enum bool serverbound = true;

			public bool onGround;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer.length+=bool.sizeof; write!(bool, Endian.bigEndian)(buffer, onGround, buffer.length-bool.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				if(buffer.length>=bool.sizeof){ onGround=read!(bool, Endian.bigEndian)(buffer); }
				return this;
			}

		}

		static struct ChatMessageClientbound {

			public enum uint packetId = 15;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public string message;
			public ubyte position;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				ubyte[] bWVzc2FnZQ=cast(ubyte[])message; buffer~=varuint.encode(bWVzc2FnZQ.length.to!uint); buffer~=bWVzc2FnZQ;
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, position, buffer.length-ubyte.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				ubyte[] bWVzc2FnZQ; bWVzc2FnZQ.length=varuint.fromBuffer(buffer);if(buffer.length>=bWVzc2FnZQ.length){ bWVzc2FnZQ=buffer[0..bWVzc2FnZQ.length]; buffer=buffer[bWVzc2FnZQ.length..$]; }; message=cast(string)bWVzc2FnZQ;
				if(buffer.length>=ubyte.sizeof){ position=read!(ubyte, Endian.bigEndian)(buffer); }
				return this;
			}

		}

		static struct ConfirmTransactionClientbound {

			public enum uint packetId = 17;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public ubyte window;
			public ushort action;
			public bool accepted;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, window, buffer.length-ubyte.sizeof);
				buffer.length+=ushort.sizeof; write!(ushort, Endian.bigEndian)(buffer, action, buffer.length-ushort.sizeof);
				buffer.length+=bool.sizeof; write!(bool, Endian.bigEndian)(buffer, accepted, buffer.length-bool.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				if(buffer.length>=ubyte.sizeof){ window=read!(ubyte, Endian.bigEndian)(buffer); }
				if(buffer.length>=ushort.sizeof){ action=read!(ushort, Endian.bigEndian)(buffer); }
				if(buffer.length>=bool.sizeof){ accepted=read!(bool, Endian.bigEndian)(buffer); }
				return this;
			}

		}

		static struct NamedSoundEffect {

			public enum uint packetId = 25;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public string name;
			public uint category;
			public Tuple!(int, "x", int, "y", int, "z") position;
			public float volume;
			public float pitch;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				ubyte[] bmFtZQ=cast(ubyte[])name; buffer~=varuint.encode(bmFtZQ.length.to!uint); buffer~=bmFtZQ;
				buffer~=varuint.encode(category);
				buffer.length+=int.sizeof; write!(int, Endian.bigEndian)(buffer, position.x, buffer.length-int.sizeof);buffer.length+=int.sizeof; write!(int, Endian.bigEndian)(buffer, position.y, buffer.length-int.sizeof);buffer.length+=int.sizeof; write!(int, Endian.bigEndian)(buffer, position.z, buffer.length-int.sizeof);
				buffer.length+=float.sizeof; write!(float, Endian.bigEndian)(buffer, volume, buffer.length-float.sizeof);
				buffer.length+=float.sizeof; write!(float, Endian.bigEndian)(buffer, pitch, buffer.length-float.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				ubyte[] bmFtZQ; bmFtZQ.length=varuint.fromBuffer(buffer);if(buffer.length>=bmFtZQ.length){ bmFtZQ=buffer[0..bmFtZQ.length]; buffer=buffer[bmFtZQ.length..$]; }; name=cast(string)bmFtZQ;
				category=varuint.fromBuffer(buffer);
				if(buffer.length>=int.sizeof){ position.x=read!(int, Endian.bigEndian)(buffer); }if(buffer.length>=int.sizeof){ position.y=read!(int, Endian.bigEndian)(buffer); }if(buffer.length>=int.sizeof){ position.z=read!(int, Endian.bigEndian)(buffer); }
				if(buffer.length>=float.sizeof){ volume=read!(float, Endian.bigEndian)(buffer); }
				if(buffer.length>=float.sizeof){ pitch=read!(float, Endian.bigEndian)(buffer); }
				return this;
			}

		}

		static struct SpawnPlayer {

			public enum uint packetId = 5;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public uint entityId;
			public UUID uuid;
			public Tuple!(double, "x", double, "y", double, "z") position;
			public ubyte yaw;
			public ubyte pitch;
			public ubyte[] metadata;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer~=varuint.encode(entityId);
				buffer~=uuid.data;
				buffer.length+=double.sizeof; write!(double, Endian.bigEndian)(buffer, position.x, buffer.length-double.sizeof);buffer.length+=double.sizeof; write!(double, Endian.bigEndian)(buffer, position.y, buffer.length-double.sizeof);buffer.length+=double.sizeof; write!(double, Endian.bigEndian)(buffer, position.z, buffer.length-double.sizeof);
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, yaw, buffer.length-ubyte.sizeof);
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, pitch, buffer.length-ubyte.sizeof);
				buffer~=metadata;
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				entityId=varuint.fromBuffer(buffer);
				if(buffer.length>=16){ ubyte[16] dXVpZA=buffer[0..16]; buffer=buffer[16..$]; uuid=UUID(dXVpZA); }
				if(buffer.length>=double.sizeof){ position.x=read!(double, Endian.bigEndian)(buffer); }if(buffer.length>=double.sizeof){ position.y=read!(double, Endian.bigEndian)(buffer); }if(buffer.length>=double.sizeof){ position.z=read!(double, Endian.bigEndian)(buffer); }
				if(buffer.length>=ubyte.sizeof){ yaw=read!(ubyte, Endian.bigEndian)(buffer); }
				if(buffer.length>=ubyte.sizeof){ pitch=read!(ubyte, Endian.bigEndian)(buffer); }
				metadata=buffer.dup; buffer.length=0;
				return this;
			}

		}

		static struct UpdateBlockEntity {

			public enum uint packetId = 9;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public ulong position;
			public ubyte action;
			public ubyte[] nbt;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer.length+=ulong.sizeof; write!(ulong, Endian.bigEndian)(buffer, position, buffer.length-ulong.sizeof);
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, action, buffer.length-ubyte.sizeof);
				buffer~=nbt;
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				if(buffer.length>=ulong.sizeof){ position=read!(ulong, Endian.bigEndian)(buffer); }
				if(buffer.length>=ubyte.sizeof){ action=read!(ubyte, Endian.bigEndian)(buffer); }
				nbt=buffer.dup; buffer.length=0;
				return this;
			}

		}

		static struct ConfirmTransactionServerbound {

			public enum uint packetId = 5;

			public enum bool clientbound = false;
			public enum bool serverbound = true;

			public ubyte window;
			public ushort action;
			public bool accepted;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, window, buffer.length-ubyte.sizeof);
				buffer.length+=ushort.sizeof; write!(ushort, Endian.bigEndian)(buffer, action, buffer.length-ushort.sizeof);
				buffer.length+=bool.sizeof; write!(bool, Endian.bigEndian)(buffer, accepted, buffer.length-bool.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				if(buffer.length>=ubyte.sizeof){ window=read!(ubyte, Endian.bigEndian)(buffer); }
				if(buffer.length>=ushort.sizeof){ action=read!(ushort, Endian.bigEndian)(buffer); }
				if(buffer.length>=bool.sizeof){ accepted=read!(bool, Endian.bigEndian)(buffer); }
				return this;
			}

		}

		static struct SpawnMob {

			public enum uint packetId = 3;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public uint entityId;
			public UUID uuid;
			public uint type;
			public Tuple!(double, "x", double, "y", double, "z") position;
			public ubyte yaw;
			public ubyte pitch;
			public ubyte headPitch;
			public Tuple!(short, "x", short, "y", short, "z") velocity;
			public ubyte[] metadata;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer~=varuint.encode(entityId);
				buffer~=uuid.data;
				buffer~=varuint.encode(type);
				buffer.length+=double.sizeof; write!(double, Endian.bigEndian)(buffer, position.x, buffer.length-double.sizeof);buffer.length+=double.sizeof; write!(double, Endian.bigEndian)(buffer, position.y, buffer.length-double.sizeof);buffer.length+=double.sizeof; write!(double, Endian.bigEndian)(buffer, position.z, buffer.length-double.sizeof);
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, yaw, buffer.length-ubyte.sizeof);
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, pitch, buffer.length-ubyte.sizeof);
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, headPitch, buffer.length-ubyte.sizeof);
				buffer.length+=short.sizeof; write!(short, Endian.bigEndian)(buffer, velocity.x, buffer.length-short.sizeof);buffer.length+=short.sizeof; write!(short, Endian.bigEndian)(buffer, velocity.y, buffer.length-short.sizeof);buffer.length+=short.sizeof; write!(short, Endian.bigEndian)(buffer, velocity.z, buffer.length-short.sizeof);
				buffer~=metadata;
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				entityId=varuint.fromBuffer(buffer);
				if(buffer.length>=16){ ubyte[16] dXVpZA=buffer[0..16]; buffer=buffer[16..$]; uuid=UUID(dXVpZA); }
				type=varuint.fromBuffer(buffer);
				if(buffer.length>=double.sizeof){ position.x=read!(double, Endian.bigEndian)(buffer); }if(buffer.length>=double.sizeof){ position.y=read!(double, Endian.bigEndian)(buffer); }if(buffer.length>=double.sizeof){ position.z=read!(double, Endian.bigEndian)(buffer); }
				if(buffer.length>=ubyte.sizeof){ yaw=read!(ubyte, Endian.bigEndian)(buffer); }
				if(buffer.length>=ubyte.sizeof){ pitch=read!(ubyte, Endian.bigEndian)(buffer); }
				if(buffer.length>=ubyte.sizeof){ headPitch=read!(ubyte, Endian.bigEndian)(buffer); }
				if(buffer.length>=short.sizeof){ velocity.x=read!(short, Endian.bigEndian)(buffer); }if(buffer.length>=short.sizeof){ velocity.y=read!(short, Endian.bigEndian)(buffer); }if(buffer.length>=short.sizeof){ velocity.z=read!(short, Endian.bigEndian)(buffer); }
				metadata=buffer.dup; buffer.length=0;
				return this;
			}

		}

		static struct JoinGame {

			public enum uint packetId = 35;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public uint entityId;
			public ubyte gamemode;
			public int dimension;
			public ubyte difficulty;
			public ubyte maxPlayers;
			public string levelType;
			public bool reducedDebug;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer.length+=uint.sizeof; write!(uint, Endian.bigEndian)(buffer, entityId, buffer.length-uint.sizeof);
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, gamemode, buffer.length-ubyte.sizeof);
				buffer.length+=int.sizeof; write!(int, Endian.bigEndian)(buffer, dimension, buffer.length-int.sizeof);
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, difficulty, buffer.length-ubyte.sizeof);
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, maxPlayers, buffer.length-ubyte.sizeof);
				ubyte[] bGV2ZWxUeXBl=cast(ubyte[])levelType; buffer~=varuint.encode(bGV2ZWxUeXBl.length.to!uint); buffer~=bGV2ZWxUeXBl;
				buffer.length+=bool.sizeof; write!(bool, Endian.bigEndian)(buffer, reducedDebug, buffer.length-bool.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				if(buffer.length>=uint.sizeof){ entityId=read!(uint, Endian.bigEndian)(buffer); }
				if(buffer.length>=ubyte.sizeof){ gamemode=read!(ubyte, Endian.bigEndian)(buffer); }
				if(buffer.length>=int.sizeof){ dimension=read!(int, Endian.bigEndian)(buffer); }
				if(buffer.length>=ubyte.sizeof){ difficulty=read!(ubyte, Endian.bigEndian)(buffer); }
				if(buffer.length>=ubyte.sizeof){ maxPlayers=read!(ubyte, Endian.bigEndian)(buffer); }
				ubyte[] bGV2ZWxUeXBl; bGV2ZWxUeXBl.length=varuint.fromBuffer(buffer);if(buffer.length>=bGV2ZWxUeXBl.length){ bGV2ZWxUeXBl=buffer[0..bGV2ZWxUeXBl.length]; buffer=buffer[bGV2ZWxUeXBl.length..$]; }; levelType=cast(string)bGV2ZWxUeXBl;
				if(buffer.length>=bool.sizeof){ reducedDebug=read!(bool, Endian.bigEndian)(buffer); }
				return this;
			}

		}

		static struct EntityStatus {

			public enum uint packetId = 27;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public uint entityId;
			public ubyte status;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer.length+=uint.sizeof; write!(uint, Endian.bigEndian)(buffer, entityId, buffer.length-uint.sizeof);
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, status, buffer.length-ubyte.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				if(buffer.length>=uint.sizeof){ entityId=read!(uint, Endian.bigEndian)(buffer); }
				if(buffer.length>=ubyte.sizeof){ status=read!(ubyte, Endian.bigEndian)(buffer); }
				return this;
			}

		}

	}

	static struct Login {

		static struct EncryptionResponse {

			public enum uint packetId = 1;

			public enum bool clientbound = false;
			public enum bool serverbound = true;

			public ubyte[] sharedSecret;
			public ubyte[] verifyToken;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer~=varuint.encode(sharedSecret.length.to!uint); buffer~=sharedSecret;
				buffer~=varuint.encode(verifyToken.length.to!uint); buffer~=verifyToken;
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				sharedSecret.length=varuint.fromBuffer(buffer);if(buffer.length>=sharedSecret.length){ sharedSecret=buffer[0..sharedSecret.length]; buffer=buffer[sharedSecret.length..$]; }
				verifyToken.length=varuint.fromBuffer(buffer);if(buffer.length>=verifyToken.length){ verifyToken=buffer[0..verifyToken.length]; buffer=buffer[verifyToken.length..$]; }
				return this;
			}

		}

		static struct SetCompression {

			public enum uint packetId = 3;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public uint thresold;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer~=varuint.encode(thresold);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				thresold=varuint.fromBuffer(buffer);
				return this;
			}

		}

		static struct Disconnect {

			public enum uint packetId = 0;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public string reason;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				ubyte[] cmVhc29u=cast(ubyte[])reason; buffer~=varuint.encode(cmVhc29u.length.to!uint); buffer~=cmVhc29u;
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				ubyte[] cmVhc29u; cmVhc29u.length=varuint.fromBuffer(buffer);if(buffer.length>=cmVhc29u.length){ cmVhc29u=buffer[0..cmVhc29u.length]; buffer=buffer[cmVhc29u.length..$]; }; reason=cast(string)cmVhc29u;
				return this;
			}

		}

		static struct LoginStart {

			public enum uint packetId = 0;

			public enum bool clientbound = false;
			public enum bool serverbound = true;

			public string username;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				ubyte[] dXNlcm5hbWU=cast(ubyte[])username; buffer~=varuint.encode(dXNlcm5hbWU.length.to!uint); buffer~=dXNlcm5hbWU;
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				ubyte[] dXNlcm5hbWU; dXNlcm5hbWU.length=varuint.fromBuffer(buffer);if(buffer.length>=dXNlcm5hbWU.length){ dXNlcm5hbWU=buffer[0..dXNlcm5hbWU.length]; buffer=buffer[dXNlcm5hbWU.length..$]; }; username=cast(string)dXNlcm5hbWU;
				return this;
			}

		}

		static struct LoginSuccess {

			public enum uint packetId = 2;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public string uuid;
			public string username;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				ubyte[] dXVpZA=cast(ubyte[])uuid; buffer~=varuint.encode(dXVpZA.length.to!uint); buffer~=dXVpZA;
				ubyte[] dXNlcm5hbWU=cast(ubyte[])username; buffer~=varuint.encode(dXNlcm5hbWU.length.to!uint); buffer~=dXNlcm5hbWU;
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				ubyte[] dXVpZA; dXVpZA.length=varuint.fromBuffer(buffer);if(buffer.length>=dXVpZA.length){ dXVpZA=buffer[0..dXVpZA.length]; buffer=buffer[dXVpZA.length..$]; }; uuid=cast(string)dXVpZA;
				ubyte[] dXNlcm5hbWU; dXNlcm5hbWU.length=varuint.fromBuffer(buffer);if(buffer.length>=dXNlcm5hbWU.length){ dXNlcm5hbWU=buffer[0..dXNlcm5hbWU.length]; buffer=buffer[dXNlcm5hbWU.length..$]; }; username=cast(string)dXNlcm5hbWU;
				return this;
			}

		}

		static struct EncryptionRequest {

			public enum uint packetId = 1;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public string serverId;
			public ubyte[] publicKey;
			public ubyte[] verifyToken;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				ubyte[] c2VydmVySWQ=cast(ubyte[])serverId; buffer~=varuint.encode(c2VydmVySWQ.length.to!uint); buffer~=c2VydmVySWQ;
				buffer~=varuint.encode(publicKey.length.to!uint); buffer~=publicKey;
				buffer~=varuint.encode(verifyToken.length.to!uint); buffer~=verifyToken;
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				ubyte[] c2VydmVySWQ; c2VydmVySWQ.length=varuint.fromBuffer(buffer);if(buffer.length>=c2VydmVySWQ.length){ c2VydmVySWQ=buffer[0..c2VydmVySWQ.length]; buffer=buffer[c2VydmVySWQ.length..$]; }; serverId=cast(string)c2VydmVySWQ;
				publicKey.length=varuint.fromBuffer(buffer);if(buffer.length>=publicKey.length){ publicKey=buffer[0..publicKey.length]; buffer=buffer[publicKey.length..$]; }
				verifyToken.length=varuint.fromBuffer(buffer);if(buffer.length>=verifyToken.length){ verifyToken=buffer[0..verifyToken.length]; buffer=buffer[verifyToken.length..$]; }
				return this;
			}

		}

	}

	static struct Status {

		static struct Pong {

			public enum uint packetId = 1;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public ulong time;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer.length+=ulong.sizeof; write!(ulong, Endian.bigEndian)(buffer, time, buffer.length-ulong.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				if(buffer.length>=ulong.sizeof){ time=read!(ulong, Endian.bigEndian)(buffer); }
				return this;
			}

		}

		static struct Handshake {

			public enum uint packetId = 0;

			public enum bool clientbound = false;
			public enum bool serverbound = true;

			public uint protocol;
			public string serverAddress;
			public ushort serverPort;
			public uint next;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer~=varuint.encode(protocol);
				ubyte[] c2VydmVyQWRkcmVz=cast(ubyte[])serverAddress; buffer~=varuint.encode(c2VydmVyQWRkcmVz.length.to!uint); buffer~=c2VydmVyQWRkcmVz;
				buffer.length+=ushort.sizeof; write!(ushort, Endian.bigEndian)(buffer, serverPort, buffer.length-ushort.sizeof);
				buffer~=varuint.encode(next);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				protocol=varuint.fromBuffer(buffer);
				ubyte[] c2VydmVyQWRkcmVz; c2VydmVyQWRkcmVz.length=varuint.fromBuffer(buffer);if(buffer.length>=c2VydmVyQWRkcmVz.length){ c2VydmVyQWRkcmVz=buffer[0..c2VydmVyQWRkcmVz.length]; buffer=buffer[c2VydmVyQWRkcmVz.length..$]; }; serverAddress=cast(string)c2VydmVyQWRkcmVz;
				if(buffer.length>=ushort.sizeof){ serverPort=read!(ushort, Endian.bigEndian)(buffer); }
				next=varuint.fromBuffer(buffer);
				return this;
			}

		}

		static struct Status {

			public enum uint packetId = 0;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public string json;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				ubyte[] anNvbg=cast(ubyte[])json; buffer~=varuint.encode(anNvbg.length.to!uint); buffer~=anNvbg;
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				ubyte[] anNvbg; anNvbg.length=varuint.fromBuffer(buffer);if(buffer.length>=anNvbg.length){ anNvbg=buffer[0..anNvbg.length]; buffer=buffer[anNvbg.length..$]; }; json=cast(string)anNvbg;
				return this;
			}

		}

		static struct Ping {

			public enum uint packetId = 1;

			public enum bool clientbound = false;
			public enum bool serverbound = true;

			public ulong time;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer~=varuint.encode(packetId); }
				buffer.length+=ulong.sizeof; write!(ulong, Endian.bigEndian)(buffer, time, buffer.length-ulong.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ uint _packet_id; _packet_id=varuint.fromBuffer(buffer); }
				if(buffer.length>=ulong.sizeof){ time=read!(ulong, Endian.bigEndian)(buffer); }
				return this;
			}

		}

	}

}
