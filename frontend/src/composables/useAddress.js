import { reactive} from 'vue';
import { getAddressListApi } from '@/api/addressBook'; // 引入你的 API 函數

const addressList = reactive([]);

const fetchAddressList = async () => {
  const response = await getAddressListApi();
  addressList.splice(0, addressList.length, ...response.data);
};

export default function useAddress() {
  return {
    addressList,
    fetchAddressList
  };
}