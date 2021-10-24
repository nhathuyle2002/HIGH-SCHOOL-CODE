const   ginp='ht.inp';
        gout='ht.out';
        a:array[1..8] of string[3]= ('TTT','TTH','THT','THH','HTT','HTH','HHT','HHH');

var     s:string[40];
        d:array[1..8] of longint;

procedure main;
var     i,j:longint;
        tm:string[3];
begin
        read(s);
        for i:=1 to length(s)-2 do
        begin
                tm:=copy(s,i,3);
                for j:=1 to 8 do
                        if tm=a[j] then inc(d[j]);
        end;
        for i:=1 to 8 do write(d[i],' ');
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        main;
        close(input);close(output);
end.