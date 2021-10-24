const   ginp='digitsum.inp';
        gout='digitsum.out';

var     gi,go:text;
        t:int64;
        a,b,c:string;

procedure input;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        read(gi,a);
end;

procedure process;
var     tm:longint;
begin
        while (a[length(a)]='9') and (length(a)>1) do
        begin
                delete(a,length(a),1);
                b:='9'+b;
                c:='0'+c;
                t:=t+9;
        end;
        if length(a)<=1 then
        begin
                b:=a+b;
                c:='0'+c;
                t:=t+ord(a[1])-48;
                exit;
        end;
        tm:=ord(a[length(a)])-48+10;
        b:='9'+b;
        c:=chr(tm-9+48)+c;
        t:=t+tm;
        delete(a,length(a),1);
        while length(a)>1 do
        begin
                tm:=ord(a[length(a)])-48+9;
                delete(a,length(a),1);
                b:='9'+b;
                c:=chr(tm-9+48)+c;
                t:=t+tm;
        end;
        b:=chr(ord(a[1])-1)+b;
        t:=t+ord(a[1])-1-48;
end;

procedure output;
begin
        while b[1]='0' do delete(b,1,1);
        while (c[1]='0') and (length(c)>1) do delete(c,1,1);
        writeln(go,t);
        write(go,b,' ',c);
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.


