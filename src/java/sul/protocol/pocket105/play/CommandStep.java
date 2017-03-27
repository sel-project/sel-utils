/*
 * This file was automatically generated by sel-utils and
 * released under the GNU General Public License version 3.
 * 
 * License: https://github.com/sel-project/sel-utils/blob/master/LICENSE
 * Repository: https://github.com/sel-project/sel-utils
 * Generated from https://github.com/sel-project/sel-utils/blob/master/xml/protocol/pocket105.xml
 */
package sul.protocol.pocket105.play;

import java.nio.charset.StandardCharsets;

import sul.utils.*;

public class CommandStep extends Packet {

	public static final byte ID = (byte)79;

	public static final boolean CLIENTBOUND = false;
	public static final boolean SERVERBOUND = true;

	@Override
	public int getId() {
		return ID;
	}

	public String command;
	public String overload;
	public int unknown2;
	public int unknown3;
	public boolean isOutput;
	public long unknown5;
	public String input;
	public String output;

	public CommandStep() {}

	public CommandStep(String command, String overload, int unknown2, int unknown3, boolean isOutput, long unknown5, String input, String output) {
		this.command = command;
		this.overload = overload;
		this.unknown2 = unknown2;
		this.unknown3 = unknown3;
		this.isOutput = isOutput;
		this.unknown5 = unknown5;
		this.input = input;
		this.output = output;
	}

	@Override
	public int length() {
		return Buffer.varuintLength(command.getBytes(StandardCharsets.UTF_8).length) + command.getBytes(StandardCharsets.UTF_8).length + Buffer.varuintLength(overload.getBytes(StandardCharsets.UTF_8).length) + overload.getBytes(StandardCharsets.UTF_8).length + Buffer.varuintLength(unknown2) + Buffer.varuintLength(unknown3) + Buffer.varulongLength(unknown5) + Buffer.varuintLength(input.getBytes(StandardCharsets.UTF_8).length) + input.getBytes(StandardCharsets.UTF_8).length + Buffer.varuintLength(output.getBytes(StandardCharsets.UTF_8).length) + output.getBytes(StandardCharsets.UTF_8).length + 2;
	}

	@Override
	public byte[] encode() {
		this._buffer = new byte[this.length()];
		this.writeBigEndianByte(ID);
		byte[] y9bfz=command.getBytes(StandardCharsets.UTF_8); this.writeVaruint((int)y9bfz.length); this.writeBytes(y9bfz);
		byte[] bzcxyq=overload.getBytes(StandardCharsets.UTF_8); this.writeVaruint((int)bzcxyq.length); this.writeBytes(bzcxyq);
		this.writeVaruint(unknown2);
		this.writeVaruint(unknown3);
		this.writeBool(isOutput);
		this.writeVarulong(unknown5);
		byte[] a5dq=input.getBytes(StandardCharsets.UTF_8); this.writeVaruint((int)a5dq.length); this.writeBytes(a5dq);
		byte[] bvcv=output.getBytes(StandardCharsets.UTF_8); this.writeVaruint((int)bvcv.length); this.writeBytes(bvcv);
		return this.getBuffer();
	}

	@Override
	public void decode(byte[] buffer) {
		this._buffer = buffer;
		readBigEndianByte();
		int bvy9bfz=this.readVaruint(); command=new String(this.readBytes(bvy9bfz), StandardCharsets.UTF_8);
		int bvbzcxyq=this.readVaruint(); overload=new String(this.readBytes(bvbzcxyq), StandardCharsets.UTF_8);
		unknown2=this.readVaruint();
		unknown3=this.readVaruint();
		isOutput=this.readBool();
		unknown5=this.readVarulong();
		int bva5dq=this.readVaruint(); input=new String(this.readBytes(bva5dq), StandardCharsets.UTF_8);
		int bvbvcv=this.readVaruint(); output=new String(this.readBytes(bvbvcv), StandardCharsets.UTF_8);
	}

	public static CommandStep fromBuffer(byte[] buffer) {
		CommandStep ret = new CommandStep();
		ret.decode(buffer);
		return ret;
	}

	@Override
	public String toString() {
		return "CommandStep(command: " + this.command + ", overload: " + this.overload + ", unknown2: " + this.unknown2 + ", unknown3: " + this.unknown3 + ", isOutput: " + this.isOutput + ", unknown5: " + this.unknown5 + ", input: " + this.input + ", output: " + this.output + ")";
	}

}