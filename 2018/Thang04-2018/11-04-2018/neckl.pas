const   ginp='neckl.inp';
        gout='neckl.out';

var     gi,go:text;
        n:longint;
        gmin,gmax:int64;
        hn:array[0..31] of int64;
        s:ansistring;

procedure input;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        read(gi,s);
        n:=length(s);
        gmin:=1000000000000000;
        gmax:=0;
end;

procedure cclt(s0:ansistring;x:char);
var     i:longint;
        tm:int64;
begin
        tm:=0;
        for i:=1 to n do
                if s0[i]=x then tm:=tm+hn[i-1];
        if tm<gmin then gmin:=tm;
        if tm>gmax then gmax:=tm;
end;

procedure process;
var     i:longint;
        ss:ansistring;
begin
        hn[0]:=1;
        for i:=1 to n do hn[i]:=hn[i-1]*2;
        ss:='';
        for i:=n downto 1 do ss:=ss+s[i];
        s:=s+s;ss:=ss+ss;
        for i:=1 to n do
        begin
                cclt(copy(s,i,n),'B');
                cclt(copy(s,i,n),'W');
                cclt(copy(ss,i,n),'B');
                cclt(copy(ss,i,n),'W');
        end;
end;

procedure output;
begin
        write(go,gmin,' ',gmax);
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.
