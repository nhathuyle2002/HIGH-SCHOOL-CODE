const   ginp='ss.inp';
        gout='ss.out';
        pt:array[1..8] of string=('TTT','TTH','THT','THH','HTT','HTH','HHT','HHH');

procedure main;
var     gi,go:text;
        i,j,t,k:longint;
        tm:string;
        s:ansistring;
        d:array[1..8] of longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,t);
        for k:=1 to t do
        begin
                readln(gi);readln(gi,s);
                fillchar(d,sizeof(d),0);
                for i:=1 to 38 do
                begin
                        tm:=copy(s,i,3);
                        for j:=1 to 8 do
                                if pt[j]=tm then inc(d[j]);
                end;
                write(go,k,' ');for i:=1 to 8 do write(go,d[i],' ');
                writeln(go);
        end;
        close(gi);close(go);
end;

begin
        main;
end.
