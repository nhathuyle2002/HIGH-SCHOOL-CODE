Const   ginp='number.inp';
        gout='number.out';

Var     n,cou:longint;
        a,res:ansistring;
        v:array[0..100010] of longint;

Procedure Enter;
Var     i,ct:longint;
        j:char;
        dd:array['0'..'9'] of boolean;
Begin
        read(a); n:=length(a);
        cou:=0; v[0]:=n+1;
        ct:=0; fillchar(dd,sizeof(dd),true);
        for i:=n downto 1 do
        begin
                if dd[a[i]] then
                begin
                        dd[a[i]]:=false; inc(ct);
                        if ct=10 then
                        begin
                                inc(cou); v[cou]:=i;
                                ct:=0; fillchar(dd,sizeof(dd),true);
                        end;
                end;
        end;
        if v[cou]=1 then res:='1' else
        if (ct=9) and (dd['0']) then
        begin
                res:='1';
                inc(cou); v[cou]:=1;
        end else
        for j:='9' downto '1' do
                if dd[j] then res:=j;
End;

Procedure Process;
Var     i,j:longint;
        x:char;
        dd:array['0'..'9'] of boolean;
Begin
        for i:=cou downto 1 do
        begin
                for j:=v[i] to v[i-1]-1 do
                        if res[cou-i+1]=a[j] then break;
                fillchar(dd,sizeof(dd),true);
                for j:=j+1 to v[i-1]-1 do dd[a[j]]:=false;
                for x:='0' to '9' do
                        if dd[x] then
                        begin
                                res:=res+x; break;
                        end;
        end;
        write(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
