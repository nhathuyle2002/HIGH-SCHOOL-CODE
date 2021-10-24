const   ginp='ticket.inp';
        gout='ticket.out';

var     n:longint;
        a:array[0..51] of string[100];
        b:string[100];
        d:array['A'..'Z'] of boolean;

procedure enter;
var     i:longint;
begin
        readln(n);
        for i:=1 to n do readln(a[i]);
        read(b);
end;

procedure process;
var     i:longint;
        ii:char;
begin
        fillchar(d,sizeof(d),false);
        for i:=1 to n do
                if (length(a[i])>length(b)) and (copy(a[i],1,length(b))=b) then d[a[i,length(b)+1]]:=true;
        write('***');
        for ii:='A' to 'Z' do
        begin
                if d[ii] then write(ii) else write('*');
                if (ord(ii)-ord('A')+4) mod 8=0 then writeln;
        end;
        write('***');
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
