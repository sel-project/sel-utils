module sul.protocol.raknet8;

import std.bitmanip : read, write;
import std.conv : to;
import std.uuid : UUID;
import std.system : Endian;
import std.typecons : Tuple, tuple;

import sul.types.var;

static struct Types {

	static struct Address {

		public ubyte type;
		public ubyte[4] ipv4;
		public ubyte[16] ipv6;
		public ushort port;

		public void encode(ref ubyte[] buffer) {
			buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, type, buffer.length-ubyte.sizeof);
			if(type==4){  buffer~=ipv4; }
			if(type==6){  buffer~=ipv6; }
			buffer.length+=ushort.sizeof; write!(ushort, Endian.bigEndian)(buffer, port, buffer.length-ushort.sizeof);
		}

		public void decode(ref ubyte[] buffer) {
			if(buffer.length>=ubyte.sizeof){ type=read!(ubyte, Endian.bigEndian)(buffer); }
			if(type==4){ if(buffer.length>=ipv4.length){ ipv4=buffer[0..ipv4.length]; buffer=buffer[ipv4.length..$]; } }
			if(type==6){ if(buffer.length>=ipv6.length){ ipv6=buffer[0..ipv6.length]; buffer=buffer[ipv6.length..$]; } }
			if(buffer.length>=ushort.sizeof){ port=read!(ushort, Endian.bigEndian)(buffer); }
		}

	}

	static struct Acknowledge {

		public bool unique;
		public int first;
		public int last;

		public void encode(ref ubyte[] buffer) {
			buffer.length+=bool.sizeof; write!(bool, Endian.bigEndian)(buffer, unique, buffer.length-bool.sizeof);
			buffer.length+=3; buffer[$-3]=first&255; buffer[$-2]=(first>>8)&255; buffer[$-1]=(first>>16)&255;
			if(unique==false){ buffer.length+=3; buffer[$-3]=last&255; buffer[$-2]=(last>>8)&255; buffer[$-1]=(last>>16)&255; }
		}

		public void decode(ref ubyte[] buffer) {
			if(buffer.length>=bool.sizeof){ unique=read!(bool, Endian.bigEndian)(buffer); }
			if(buffer.length>=3){ first=buffer[0]|(buffer[1]<<8)|(buffer[2]<<16); buffer=buffer[3..$]; }
			if(unique==false){ if(buffer.length>=3){ last=buffer[0]|(buffer[1]<<8)|(buffer[2]<<16); buffer=buffer[3..$]; } }
		}

	}

	static struct Encapsulation {

		public ubyte info;
		public ushort length;
		public int messageIndex;
		public int orderIndex;
		public ubyte orderChannel;
		public Types.Split split;
		public ubyte[] payload;

		public void encode(ref ubyte[] buffer) {
			buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, info, buffer.length-ubyte.sizeof);
			buffer.length+=ushort.sizeof; write!(ushort, Endian.bigEndian)(buffer, length, buffer.length-ushort.sizeof);
			if((info&0x7f)>=64){ buffer.length+=3; buffer[$-3]=messageIndex&255; buffer[$-2]=(messageIndex>>8)&255; buffer[$-1]=(messageIndex>>16)&255; }
			if((info&0x7f)>=96){ buffer.length+=3; buffer[$-3]=orderIndex&255; buffer[$-2]=(orderIndex>>8)&255; buffer[$-1]=(orderIndex>>16)&255; }
			if((info&0x7f)>=96){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, orderChannel, buffer.length-ubyte.sizeof); }
			if((info&0x10)!=0){ split.encode(buffer); }
			buffer~=payload;
		}

		public void decode(ref ubyte[] buffer) {
			if(buffer.length>=ubyte.sizeof){ info=read!(ubyte, Endian.bigEndian)(buffer); }
			if(buffer.length>=ushort.sizeof){ length=read!(ushort, Endian.bigEndian)(buffer); }
			if((info&0x7f)>=64){ if(buffer.length>=3){ messageIndex=buffer[0]|(buffer[1]<<8)|(buffer[2]<<16); buffer=buffer[3..$]; } }
			if((info&0x7f)>=96){ if(buffer.length>=3){ orderIndex=buffer[0]|(buffer[1]<<8)|(buffer[2]<<16); buffer=buffer[3..$]; } }
			if((info&0x7f)>=96){ if(buffer.length>=ubyte.sizeof){ orderChannel=read!(ubyte, Endian.bigEndian)(buffer); } }
			if((info&0x10)!=0){ split.decode(buffer); }
			payload=buffer.dup; buffer.length=0;
		}

	}

	static struct Split {

		public uint count;
		public ushort id;
		public uint order;

		public void encode(ref ubyte[] buffer) {
			buffer.length+=uint.sizeof; write!(uint, Endian.bigEndian)(buffer, count, buffer.length-uint.sizeof);
			buffer.length+=ushort.sizeof; write!(ushort, Endian.bigEndian)(buffer, id, buffer.length-ushort.sizeof);
			buffer.length+=uint.sizeof; write!(uint, Endian.bigEndian)(buffer, order, buffer.length-uint.sizeof);
		}

		public void decode(ref ubyte[] buffer) {
			if(buffer.length>=uint.sizeof){ count=read!(uint, Endian.bigEndian)(buffer); }
			if(buffer.length>=ushort.sizeof){ id=read!(ushort, Endian.bigEndian)(buffer); }
			if(buffer.length>=uint.sizeof){ order=read!(uint, Endian.bigEndian)(buffer); }
		}

	}

}

static struct Packets {

	static struct Login {

		static struct OpenConnectionRequest2 {

			public enum ubyte packetId = 7;

			public enum bool clientbound = false;
			public enum bool serverbound = true;

			public ubyte[16] magic;
			public Types.Address serverAddress;
			public ushort mtuLength;
			public long clientId;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				 buffer~=magic;
				serverAddress.encode(buffer);
				buffer.length+=ushort.sizeof; write!(ushort, Endian.bigEndian)(buffer, mtuLength, buffer.length-ushort.sizeof);
				buffer.length+=long.sizeof; write!(long, Endian.bigEndian)(buffer, clientId, buffer.length-long.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				if(buffer.length>=magic.length){ magic=buffer[0..magic.length]; buffer=buffer[magic.length..$]; }
				serverAddress.decode(buffer);
				if(buffer.length>=ushort.sizeof){ mtuLength=read!(ushort, Endian.bigEndian)(buffer); }
				if(buffer.length>=long.sizeof){ clientId=read!(long, Endian.bigEndian)(buffer); }
				return this;
			}

		}

		static struct ClientCancelConnection {

			public enum ubyte packetId = 21;

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

		static struct OpenConnectionReply2 {

			public enum ubyte packetId = 8;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public ubyte[16] magic;
			public long serverId;
			public Types.Address serverAddress;
			public ushort mtuLength;
			public bool security;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				 buffer~=magic;
				buffer.length+=long.sizeof; write!(long, Endian.bigEndian)(buffer, serverId, buffer.length-long.sizeof);
				serverAddress.encode(buffer);
				buffer.length+=ushort.sizeof; write!(ushort, Endian.bigEndian)(buffer, mtuLength, buffer.length-ushort.sizeof);
				buffer.length+=bool.sizeof; write!(bool, Endian.bigEndian)(buffer, security, buffer.length-bool.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				if(buffer.length>=magic.length){ magic=buffer[0..magic.length]; buffer=buffer[magic.length..$]; }
				if(buffer.length>=long.sizeof){ serverId=read!(long, Endian.bigEndian)(buffer); }
				serverAddress.decode(buffer);
				if(buffer.length>=ushort.sizeof){ mtuLength=read!(ushort, Endian.bigEndian)(buffer); }
				if(buffer.length>=bool.sizeof){ security=read!(bool, Endian.bigEndian)(buffer); }
				return this;
			}

		}

		static struct ClientHandshake {

			public enum ubyte packetId = 19;

			public enum bool clientbound = false;
			public enum bool serverbound = true;

			public Types.Address clientAddress;
			public Types.Address[10] systemAddresses;
			public long ping;
			public long pong;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				clientAddress.encode(buffer);
				foreach(c3lzdGVtQWRkcmVz;systemAddresses){ c3lzdGVtQWRkcmVz.encode(buffer); }
				buffer.length+=long.sizeof; write!(long, Endian.bigEndian)(buffer, ping, buffer.length-long.sizeof);
				buffer.length+=long.sizeof; write!(long, Endian.bigEndian)(buffer, pong, buffer.length-long.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				clientAddress.decode(buffer);
				foreach(ref c3lzdGVtQWRkcmVz;systemAddresses){ c3lzdGVtQWRkcmVz.decode(buffer);}
				if(buffer.length>=long.sizeof){ ping=read!(long, Endian.bigEndian)(buffer); }
				if(buffer.length>=long.sizeof){ pong=read!(long, Endian.bigEndian)(buffer); }
				return this;
			}

		}

		static struct OpenConnectionReply1 {

			public enum ubyte packetId = 6;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public ubyte[16] magic;
			public long serverId;
			public bool security;
			public ushort mtuLength;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				 buffer~=magic;
				buffer.length+=long.sizeof; write!(long, Endian.bigEndian)(buffer, serverId, buffer.length-long.sizeof);
				buffer.length+=bool.sizeof; write!(bool, Endian.bigEndian)(buffer, security, buffer.length-bool.sizeof);
				buffer.length+=ushort.sizeof; write!(ushort, Endian.bigEndian)(buffer, mtuLength, buffer.length-ushort.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				if(buffer.length>=magic.length){ magic=buffer[0..magic.length]; buffer=buffer[magic.length..$]; }
				if(buffer.length>=long.sizeof){ serverId=read!(long, Endian.bigEndian)(buffer); }
				if(buffer.length>=bool.sizeof){ security=read!(bool, Endian.bigEndian)(buffer); }
				if(buffer.length>=ushort.sizeof){ mtuLength=read!(ushort, Endian.bigEndian)(buffer); }
				return this;
			}

		}

		static struct ClientConnect {

			public enum ubyte packetId = 9;

			public enum bool clientbound = false;
			public enum bool serverbound = true;

			public long clientId;
			public long ping;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				buffer.length+=long.sizeof; write!(long, Endian.bigEndian)(buffer, clientId, buffer.length-long.sizeof);
				buffer.length+=long.sizeof; write!(long, Endian.bigEndian)(buffer, ping, buffer.length-long.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				if(buffer.length>=long.sizeof){ clientId=read!(long, Endian.bigEndian)(buffer); }
				if(buffer.length>=long.sizeof){ ping=read!(long, Endian.bigEndian)(buffer); }
				return this;
			}

		}

		static struct OpenConnectionRequest1 {

			public enum ubyte packetId = 5;

			public enum bool clientbound = false;
			public enum bool serverbound = true;

			public ubyte[16] magic;
			public ubyte protocol;
			public ubyte[] mtu;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				 buffer~=magic;
				buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, protocol, buffer.length-ubyte.sizeof);
				buffer~=mtu;
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				if(buffer.length>=magic.length){ magic=buffer[0..magic.length]; buffer=buffer[magic.length..$]; }
				if(buffer.length>=ubyte.sizeof){ protocol=read!(ubyte, Endian.bigEndian)(buffer); }
				mtu=buffer.dup; buffer.length=0;
				return this;
			}

		}

		static struct ServerHandshake {

			public enum ubyte packetId = 16;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public Types.Address clientAddress;
			public ushort mtuLength;
			public Types.Address[10] systemAddresses;
			public long ping;
			public long pong;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				clientAddress.encode(buffer);
				buffer.length+=ushort.sizeof; write!(ushort, Endian.bigEndian)(buffer, mtuLength, buffer.length-ushort.sizeof);
				foreach(c3lzdGVtQWRkcmVz;systemAddresses){ c3lzdGVtQWRkcmVz.encode(buffer); }
				buffer.length+=long.sizeof; write!(long, Endian.bigEndian)(buffer, ping, buffer.length-long.sizeof);
				buffer.length+=long.sizeof; write!(long, Endian.bigEndian)(buffer, pong, buffer.length-long.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				clientAddress.decode(buffer);
				if(buffer.length>=ushort.sizeof){ mtuLength=read!(ushort, Endian.bigEndian)(buffer); }
				foreach(ref c3lzdGVtQWRkcmVz;systemAddresses){ c3lzdGVtQWRkcmVz.decode(buffer);}
				if(buffer.length>=long.sizeof){ ping=read!(long, Endian.bigEndian)(buffer); }
				if(buffer.length>=long.sizeof){ pong=read!(long, Endian.bigEndian)(buffer); }
				return this;
			}

		}

	}

	static struct Status {

		static struct Pong {

			public enum ubyte packetId = 28;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public long ping;
			public long serverId;
			public ubyte[16] magic;
			public string status;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				buffer.length+=long.sizeof; write!(long, Endian.bigEndian)(buffer, ping, buffer.length-long.sizeof);
				buffer.length+=long.sizeof; write!(long, Endian.bigEndian)(buffer, serverId, buffer.length-long.sizeof);
				 buffer~=magic;
				ubyte[] c3RhdHVz=cast(ubyte[])status; buffer.length+=ushort.sizeof; write!(ushort, Endian.bigEndian)(buffer, c3RhdHVz.length.to!ushort, buffer.length-ushort.sizeof); buffer~=c3RhdHVz;
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				if(buffer.length>=long.sizeof){ ping=read!(long, Endian.bigEndian)(buffer); }
				if(buffer.length>=long.sizeof){ serverId=read!(long, Endian.bigEndian)(buffer); }
				if(buffer.length>=magic.length){ magic=buffer[0..magic.length]; buffer=buffer[magic.length..$]; }
				ubyte[] c3RhdHVz; if(buffer.length>=ushort.sizeof){ c3RhdHVz.length=read!(ushort, Endian.bigEndian)(buffer); }if(buffer.length>=c3RhdHVz.length){ c3RhdHVz=buffer[0..c3RhdHVz.length]; buffer=buffer[c3RhdHVz.length..$]; }; status=cast(string)c3RhdHVz;
				return this;
			}

		}

		static struct Ping {

			public enum ubyte packetId = 1;

			public enum bool clientbound = false;
			public enum bool serverbound = true;

			public long ping;
			public ubyte[16] magic;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				buffer.length+=long.sizeof; write!(long, Endian.bigEndian)(buffer, ping, buffer.length-long.sizeof);
				 buffer~=magic;
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				if(buffer.length>=long.sizeof){ ping=read!(long, Endian.bigEndian)(buffer); }
				if(buffer.length>=magic.length){ magic=buffer[0..magic.length]; buffer=buffer[magic.length..$]; }
				return this;
			}

		}

	}

	static struct Connection {

		static struct Encapsulated {

			public enum ubyte packetId = 132;

			public enum bool clientbound = true;
			public enum bool serverbound = true;

			public int count;
			public Types.Encapsulation encapsulation;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				buffer.length+=3; buffer[$-3]=count&255; buffer[$-2]=(count>>8)&255; buffer[$-1]=(count>>16)&255;
				encapsulation.encode(buffer);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				if(buffer.length>=3){ count=buffer[0]|(buffer[1]<<8)|(buffer[2]<<16); buffer=buffer[3..$]; }
				encapsulation.decode(buffer);
				return this;
			}

		}

		static struct Pong {

			public enum ubyte packetId = 3;

			public enum bool clientbound = true;
			public enum bool serverbound = false;

			public long time;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				buffer.length+=long.sizeof; write!(long, Endian.bigEndian)(buffer, time, buffer.length-long.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				if(buffer.length>=long.sizeof){ time=read!(long, Endian.bigEndian)(buffer); }
				return this;
			}

		}

		static struct Ack {

			public enum ubyte packetId = 192;

			public enum bool clientbound = true;
			public enum bool serverbound = true;

			public Types.Acknowledge[] packets;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				buffer.length+=ushort.sizeof; write!(ushort, Endian.bigEndian)(buffer, packets.length.to!ushort, buffer.length-ushort.sizeof);foreach(cGFja2V0cw;packets){ cGFja2V0cw.encode(buffer); }
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				if(buffer.length>=ushort.sizeof){ packets.length=read!(ushort, Endian.bigEndian)(buffer); }foreach(ref cGFja2V0cw;packets){ cGFja2V0cw.decode(buffer);}
				return this;
			}

		}

		static struct Ping {

			public enum ubyte packetId = 0;

			public enum bool clientbound = false;
			public enum bool serverbound = true;

			public long time;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				buffer.length+=long.sizeof; write!(long, Endian.bigEndian)(buffer, time, buffer.length-long.sizeof);
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				if(buffer.length>=long.sizeof){ time=read!(long, Endian.bigEndian)(buffer); }
				return this;
			}

		}

		static struct Nack {

			public enum ubyte packetId = 160;

			public enum bool clientbound = true;
			public enum bool serverbound = true;

			public Types.Acknowledge[] packets;

			public ubyte[] encode(bool write_id=true)() {
				ubyte[] buffer;
				static if(write_id){ buffer.length+=ubyte.sizeof; write!(ubyte, Endian.bigEndian)(buffer, packetId, buffer.length-ubyte.sizeof); }
				buffer.length+=ushort.sizeof; write!(ushort, Endian.bigEndian)(buffer, packets.length.to!ushort, buffer.length-ushort.sizeof);foreach(cGFja2V0cw;packets){ cGFja2V0cw.encode(buffer); }
				return buffer;
			}

			public typeof(this) decode(bool read_id=true)(ubyte[] buffer) {
				static if(read_id){ ubyte _packet_id; if(buffer.length>=ubyte.sizeof){ _packet_id=read!(ubyte, Endian.bigEndian)(buffer); } }
				if(buffer.length>=ushort.sizeof){ packets.length=read!(ushort, Endian.bigEndian)(buffer); }foreach(ref cGFja2V0cw;packets){ cGFja2V0cw.decode(buffer);}
				return this;
			}

		}

	}

}
